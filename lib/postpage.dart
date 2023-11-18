import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

class PostPage extends StatefulWidget {
  PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var weightUnits = [
    'grams',
    'kilograms',
    'pounds',
    'ounces',
    'milliliters',
    'liters',
    'teaspoons',
    'tablespoons',
    'cups',
    'fluid ounces',
  ];

  int _currentValue = 2;
  String currentUnit = 'grams';
  final GlobalKey _imageKey = GlobalKey();
  Random random = Random();

  // TODO Data to be converted to json
  Map<String, dynamic> data = {
    'id': '',
    'name': '',
    'servings': 2, // Default value
    'time': '', // In minutes
    'ingredients': [],
    'steps': [],
    'tags': [],
    'photo': '',
    'rating': 5.0,
    'numbOfCalories': 0,
  };

  var timeController = TextEditingController(text: '');
  var nameController = TextEditingController(text: '');


  File? _imageFile;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        data['photo'] = pickedFile.path;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> ingredientWidgets = [];
    List<Widget> stepsWidgets = [];
    List<Widget> tagsWidgets = [];

    if (data['ingredients'] != null && data['ingredients'] is List) {
      ingredientWidgets = List.generate(
        data['ingredients'].length,
        (index) {
          Map ingredient = data['ingredients'][index];
          if (ingredient != null &&
              ingredient['name'] is String &&
              ingredient['quantity'] is String &&
              ingredient['unit'] is String) {
            return IngredientWidget(
              name: ingredient['name'],
              quantity: ingredient['quantity'],
              unit: ingredient['unit'],
              index: index,
              onDelete: (int index) {
                setState(() {
                  data['ingredients'].removeAt(index);
                });
              },
            );
          } else {
            // Handle the case when an ingredient is null or not a List with at least 3 elements
            return SizedBox.shrink(); // or any other placeholder widget
          }
        },
      );
    } else {
      // Handle the case when 'ingredients' is null or not a List
      print('Ingredients data is missing or not a List');
    }

    if (data['steps'] != null && data['steps'] is List) {
      stepsWidgets = List.generate(
        data['steps'].length,
        (index) {
          String step = data['steps'][index];
          if (step != null && step is String) {
            return IngredientWidget(
              name: "${index + 1}. $step",
              quantity: "",
              unit: "",
              index: index,
              onDelete: (int index) {
                setState(() {
                  data['steps'].removeAt(index);
                });
              },
            );
          } else {
            // Handle the case when an ingredient is null or not a List with at least 3 elements
            return SizedBox.shrink(); // or any other placeholder widget
          }
        },
      );
    } else {
      // Handle the case when 'ingredients' is null or not a List
      print('Ingredients data is missing or not a List');
    }

    if(data['tags'] != null && data['tags'] is List) {
      tagsWidgets = List.generate(
        data['tags'].length,
        (index) {
          String tag = data['tags'][index];
          if (tag != null && tag is String) {
            return IngredientWidget(
              name: tag,
              quantity: "",
              unit: "",
              index: index,
              onDelete: (int index) {
                setState(() {
                  data['tags'].removeAt(index);
                });
              },
            );
          } else {
            // Handle the case when an ingredient is null or not a List with at least 3 elements
            return SizedBox.shrink(); // or any other placeholder widget
          }
        },
      );
    } else {
      // Handle the case when 'ingredients' is null or not a List
      print('Ingredients data is missing or not a List');
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Create Recipe', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Text('Name :'),
                    const SizedBox(width: 10),
                    Expanded(
                        child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'What do you call the recipe?',
                        border: InputBorder.none,
                      ),
                    ))
                  ],
                )),
            divider(),
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],),

                    child: Row(
                      children: [
                        const Text('👥 Servings'),
                        const SizedBox(width: 150),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _showNumberSelection(context,
                                  (int selectedValue) {
                                setState(() {
                                  _currentValue = selectedValue;
                                  data.update(
                                      'servings', (value) => selectedValue);
                                  //Todo
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5), // Adjust button padding
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_currentValue',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 81, 35, 19),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color.fromARGB(255, 81, 35, 19),
                                ),
                              ],
                            ),
                          ),
                        ) // Number button
                      ],
                    )),
                const SizedBox(height: 10), // Add space between the boxes
                numInputBox(context, '⏳ Est. Time (min.)', 'How long to make?'),
              ],
            ),
            divider(),
            header('🍱 Ingredients'),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showIngredientAdd(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5), // Adjust button padding
                      ),
                      child: Icon(Icons.add),
                    ),
                    ingredientWidgets.length > 0
                        ? Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: ingredientWidgets,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                )),
            const SizedBox(height: 10),
            header('📋 Steps'),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showStepAdd(context, 'steps', 'Step');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5), // Adjust button padding
                      ),
                      child: Icon(Icons.add),
                    ),
                    stepsWidgets.length > 0
                        ? Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: stepsWidgets,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                )),
            const SizedBox(height: 10),
            header('📸 Photo'),
            Row(
              children: [
                const SizedBox(width: 20),
                Center(
                  child: _imageFile == null
                      ? ElevatedButton(
                          onPressed: _getImage,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            alignment: Alignment.center,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt),
                                SizedBox(height: 8.0),
                                Text("Add Cover Photo",
                                    textAlign: TextAlign.center),
                              ],
                            ),
                          ),
                        )
                      : GestureDetector(
                        onTap: () {
                          final RenderBox button = _imageKey.currentContext!.findRenderObject() as RenderBox;
                          final Offset offset = button.localToGlobal(Offset.zero);
                          final RelativeRect position = RelativeRect.fromRect(
                            Rect.fromPoints(
                              offset,
                              offset.translate(button.size.width + 70, button.size.height),
                            ),
                            Offset.zero & MediaQuery.of(context).size,
                          );
                          showMenu(
                            context: context,
                            position: position,
                            items: [
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            elevation: 8.0,
                          ).then((value) {
                            if (value == 'delete') {
                              // Handle delete action
                              setState(() {
                                _imageFile = null;
                              });
                            }
                          });
                        },
                        child: ClipRRect(
                          key: _imageKey,
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                          child: Image.file(
                            _imageFile!,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            header('🏷️ Tags'),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showStepAdd(context, 'tags', 'Tag');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5), // Adjust button padding
                      ),
                      child: Icon(Icons.add),
                    ),
                    tagsWidgets.length > 0
                        ? Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: tagsWidgets,
                      ),
                    )
                        : SizedBox.shrink(),
                  ],
                )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 246, 240, 232),
        child: ElevatedButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            data['name'] = nameController.text;
            data['time'] = timeController.text;
            if(data['name'] == '' || data['time'] == '' || data['ingredients'].length == 0 || data['steps'].length == 0 || data['tags'].length == 0 || data['photo'] == '') {
              const snackBar = SnackBar(
                content: Text('Please fill in all fields'),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context)
                  .showSnackBar(snackBar);
              return;
            }
            // TODO: Transform data into json
            String jsonString = json.encode(data);
            saveJsonToFile(jsonString);
            print(jsonString);
            print('Recipe posted');

            // Clear all fields
            setState(() {
              nameController = TextEditingController(text: '');
              timeController = TextEditingController(text: '');
              data['name'] = '';
              data['servings'] = 2;
              data['time'] = '';
              data['ingredients'] = [];
              data['steps'] = [];
              data['tags'] = [];
              data['photo'] = '';
              data['numbOfCalories'] = 150 + random.nextInt(1000 - 150 + 1); // Random number between 150 and 1000
              _imageFile = null;
              _currentValue = 2;
            });
            const snackBar = SnackBar(
              content: Text('Recipe posted!'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context)
                .showSnackBar(snackBar);
            },
          child: const Text(
            'POST',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 81, 35, 19),
            ),
          ),
        ),
      ),
    );
  }

  String generateHash(String data) {
    List<int> bytes = utf8.encode(data);
    Digest digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> saveJsonToFile(String jsonString) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      String hash = generateHash(jsonString);
      final File file = File('${directory.path}/$hash.json');

      // Write the JSON string to the file
      await file.writeAsString(jsonString);

      print('JSON saved to file: ${file.path}');
    } catch (e) {
      print('Error saving JSON to file: $e');
    }
  }

  void _showStepAdd(BuildContext context, String dataValue, String hintText) {
    final stepController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  height: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            if (stepController.text.isNotEmpty) {
                              //String newStep = (data['steps'].length + 1).toString() + '. ' + stepController.text;
                              data.update(dataValue,
                                  (value) => value! + [stepController.text]);
                              setState(() {});
                              setModalState(() {});
                              Navigator.pop(context);
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Please fill in all fields'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5), // Adjust button padding
                          ),
                          child: const Text('Done'),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.mode_edit),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextFormField(
                                  controller: stepController,
                                  maxLines: null, // Allow multiple lines
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: hintText,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            );
          });
        });
  }

  void _showIngredientAdd(BuildContext context) async {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  height: 300.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                amountController.text.isNotEmpty) {
                              data.update(
                                  'ingredients',
                                  (value) =>
                                      value! +
                                      [
                                        {
                                          'name': nameController.text,
                                          'quantity': amountController.text,
                                          'unit': currentUnit,
                                        }
                                      ]);
                              print(data);
                              setState(() {});
                              setModalState(() {});
                              Navigator.pop(context);
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Please fill in all fields'),
                                duration: Duration(seconds: 1),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5), // Adjust button padding
                          ),
                          child: const Text('Done'),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(Icons.search),
                              const SizedBox(width: 10),
                              Expanded(
                                  child: TextFormField(
                                controller: nameController,
                                decoration: const InputDecoration(
                                  hintText: 'Ingredient',
                                  border: InputBorder.none,
                                ),
                              ))
                            ],
                          )),
                      const SizedBox(height: 10),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              const Icon(Icons.scale),
                              const SizedBox(width: 7),
                              Expanded(
                                  child: TextFormField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Quantity',
                                  border: InputBorder.none,
                                ),
                              )),
                              Container(
                                width: 90,
                                child: DropdownButton(
                                  isExpanded: true,
                                  // Initial Value
                                  value: currentUnit,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.arrow_drop_down),

                                  // Array list of items
                                  items: weightUnits.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextStyle(fontSize: 12)),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setModalState(() {
                                      currentUnit = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          )),
                      //  TODO
                    ],
                  )),
            );
          });
        });
  }

  void _showNumberSelection(
      BuildContext context, void Function(int) callback) async {
    int? value = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: 200.0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      NumberPicker(
                        value: _currentValue,
                        minValue: 1,
                        maxValue: 20,
                        onChanged: (value) {
                          setModalState(() {
                            _currentValue = value;
                            callback(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (value != null) {
      callback(value);
    }
  }

  Widget addInput(String addButtonText, void Function() onPressedAction) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                onPressedAction();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 5), // Adjust button padding
              ),
              child: Icon(Icons.add),
            ),
          ],
        ));
  }

  Widget header(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium, // Use headline style
      ),
    );
  }

  Widget divider() {
    return Container(
      height: 1, // Height of the divider
      color: Colors.purple[100], // Color of the divider
      margin: EdgeInsets.all(15), // Adjust vertical margin
    );
  }

  Widget postButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add your button's onPressed action here
        print('Post button pressed');
        saveJsonToFile(json.encode(data));
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor:
            const Color(0xFFE7D8FF), // Customize the background color
      ),
      child: const Padding(
        padding: EdgeInsets.all(2.0),
        child: Text(
          'Post',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), // Text color
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  Widget numInputBox(
      BuildContext context, String inputName, String inputDescription) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],),
        child: Row(
          children: [
            Text('$inputName :'),
            const SizedBox(width: 10),
            Expanded(
                child: TextFormField(
              controller: timeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: inputDescription,
                border: InputBorder.none,
              ),
            ))
          ],
        ));
  }
}

class IngredientWidget extends StatelessWidget {
  final int index;
  final String name;
  final String quantity;
  final String unit;
  final Function(int) onDelete;

  IngredientWidget(
      {required this.name,
      required this.quantity,
      required this.unit,
      required this.index,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Text text;
    if (quantity != "" && unit != "") {
      text = Text('$name ($quantity $unit)');
    } else {
      text = Text(name);
    }
    return ElevatedButton(
        onPressed: () {
          final RenderBox button = context.findRenderObject() as RenderBox;
          final Offset offset = button.localToGlobal(Offset.zero);
          final RelativeRect position = RelativeRect.fromRect(
            Rect.fromPoints(
              offset,
              offset.translate(button.size.width - 70, button.size.height),
            ),
            Offset.zero & MediaQuery.of(context).size,
          );
          showMenu(
            context: context,
            position: position,
            items: [
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
            elevation: 8.0,
          ).then((value) {
            if (value == 'delete') {
              // Handle delete action
              onDelete(index);
              print('Deleting item at index $index');
            }
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 5), // Adjust button padding
        ),
        child: text);
  }
}

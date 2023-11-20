import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

class FiltersPage extends StatefulWidget {
  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
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

  int _currentValueMin = 2;
  int _currentValueMax = 3;
  String currentUnit = 'grams';

  // TODO Data to be converted to json
  Map<String, dynamic> data = {
    'name': '',
    'servings': 2, // Default value
    'time': 0, // In minutes
    'ingredients': [],
    'steps': [],
  };

  var timeController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    List<Widget> ingredientWidgets = [];
    List<Widget> dietWidgets = [];

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

    if (data['diets'] != null && data['diets'] is List) {
      dietWidgets = List.generate(
        data['diets'].length,
        (index) {
          String diet = data['diets'][index];
          if (diet != null && diet is String) {
            return DietWidget(
              diet: diet,
              onDelete: (int index) {
                setState(() {
                  data['diets'].removeAt(index);
                });
              },
            );
          } else {
            return SizedBox.shrink();
          }
        },
      );
    } else {
      print('Diets data is missing or not a List');
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filters', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                            color: Colors.grey.withOpacity(0.5), // Shadow color
                            spreadRadius: 2, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset:
                                Offset(0, 3), // Offset in x and y directions
                          )
                        ]),
                    child: Row(
                      children: [
                        const Text('👥 Servings'),
                        const SizedBox(width: 30),
                        const Text('Min:'),
                        Container(
                          width: 60, // Set the width explicitly
                          child: ElevatedButton(
                            onPressed: () {
                              _showNumberSelectionMin(context,
                                  (int selectedValue) {
                                setState(() {
                                  _currentValueMin = selectedValue;
                                  data.update(
                                      'servings', (value) => selectedValue);
                                  // Todo
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ), // Adjust button padding
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_currentValueMin',
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
                        ),
                        const SizedBox(width: 10),
                        const Text('Max:'),
                        Container(
                          width: 60, // Set the width explicitly
                          child: ElevatedButton(
                            onPressed: () {
                              _showNumberSelectionMax(context,
                                  (int selectedValue) {
                                setState(() {
                                  _currentValueMax = selectedValue;
                                  data.update(
                                      'servings', (value) => selectedValue);
                                  // Todo
                                });
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ), // Adjust button padding
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_currentValueMax',
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
                numInputBox(context, '⏳ Est. Time (min.)', 'Max time?'),
              ],
            ),
            divider(),
            const SizedBox(height: 10),
            header('Diets'),
            addInput('Add Diets', () {}),
            const SizedBox(height: 10),
            header('Intolerances'),
            addInput('Add Intolerances', () {}),
            const SizedBox(height: 10),
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
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: Offset(0, 3), // Offset in x and y directions
                      )
                    ]),
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
            header('Blacklist'),
            addInput("Add Ingredients you don't want to see", () {}),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color.fromARGB(255, 246, 240, 232),
        child: ElevatedButton(
          onPressed: () {
            if (_currentValueMax >= _currentValueMin) {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            } else {
              const snackBar = SnackBar(
                content: Text('Max servings must be greater than min servings'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: const Text(
            'DONE',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 81, 35, 19),
            ),
          ),
        ),
      ),
    );
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

  void _showNumberSelectionMin(
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
                        value: _currentValueMin,
                        minValue: 0,
                        maxValue: 20,
                        onChanged: (value) {
                          setModalState(() {
                            _currentValueMin = value;
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

  void _showNumberSelectionMax(
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
                        value: _currentValueMax,
                        minValue: 0,
                        maxValue: 20,
                        onChanged: (value) {
                          setModalState(() {
                            _currentValueMax = value;
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Offset in x and y directions
              )
            ]),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(0, 3), // Offset in x and y directions
              )
            ]),
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

class DietWidget extends StatelessWidget {
  final String diet;
  final Function(int) onDelete;

  DietWidget({required this.diet, required this.onDelete});

  @override
  Widget build(BuildContext context) {
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
            onDelete(0); // Assuming there is only one diet in each widget
          }
        });
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
      child: Text('$diet'),
    );
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
        child: Text('$name ($quantity $unit)'));
  }
}

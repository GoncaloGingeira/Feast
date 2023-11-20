import 'package:feast/recipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class RecipeExecutePage extends StatefulWidget {
  final Recipe recipe;

  const RecipeExecutePage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeExecutePage> createState() => _RecipeExecutePageState();
}

class _RecipeExecutePageState extends State<RecipeExecutePage> {
  int _currentStep = 1;
  int _timerSeconds = 5;
  final CountdownController _timerController = CountdownController();
  var timeController = TextEditingController(text: '');
  bool _showingTimer = false;

  final Color _counterButtonsColor = Color.fromRGBO(79, 32, 13, 1);

  @override
  Widget build(BuildContext context) {

    return Material(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            iconSize: 34,
            icon: const Icon(Icons.timer),
            onPressed: () {
              showTimerPopUp(context);
              setState(() {});
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text('Step $_currentStep', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (_currentStep > 1) {
                        _currentStep--;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 132, 0,
                            1), // Adjust the button color as needed
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white, // Adjust the icon color as needed
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 250,
                        // Adjust the width as needed
                        height: 300,
                        // Adjust the height as needed
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Text(
                              widget.recipe.instructions[_currentStep - 1],
                              style: const TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          for (int i = 0;
                              i < widget.recipe.instructions.length;
                              i++)
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i == _currentStep - 1
                                    ? const Color.fromRGBO(255, 132, 0, 1)
                                    : Colors
                                        .grey, // Adjust the button color as needed
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (_currentStep < widget.recipe.instructions.length) {
                        _currentStep++;
                        setState(() {});
                      }
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 132, 0,
                            1), // Adjust the button color as needed
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white, // Adjust the icon color as needed
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _showingTimer ? counter() : Container(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget divider() {
    return Container(
      height: 1, // Height of the divider
      color: Color.fromRGBO(79, 32, 13, 1), // Color of the divider
      margin: EdgeInsets.all(15), // Adjust vertical margin
    );
  }

  Widget counter() {
    Widget counter = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        divider(),
        //buildStartTimerButton(),
        SizedBox(height: 20),
        Countdown(
          controller: _timerController,
          seconds: _timerSeconds,
          build: (_, double time) => Text(
            time.toString(),
            style: const TextStyle(
              fontSize: 50,
            ),
          ),
          interval: const Duration(milliseconds: 100),
          onFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Timer is done!'),
              ),
            );
          },
        ),
      ],
    );
    _timerController.start();
    return counter;
  }

  Widget buildCounterButton(String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _counterButtonsColor,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStartTimerButton() {
    return InkWell(
      onTap: () {
        _timerController.start();
      },
      child: Container(
        width: 170,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
          color: const Color.fromRGBO(255, 132, 0, 1),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              "Start Timer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTimerPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                  alignment: Alignment.center,
                  height: 120.0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        numInputBox(context, 'Time', 'Insert seconds'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                _showingTimer = true;
                                setState(() {});
                                _timerSeconds = int.parse(timeController.text);
                                _timerController.start();
                                Navigator.pop(context);
                              },
                              child: const Text('Start'),
                            ),
                            TextButton(
                              onPressed: () {
                                _showingTimer = false;
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )));
        });
  }

  Widget numInputBox(
      BuildContext context, String inputName, String inputDescription) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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

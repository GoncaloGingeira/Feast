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
                onPressed: () { _showingTimer = !_showingTimer;
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
                  Text(
                      'Step $_currentStep', style: const TextStyle(fontSize: 20)),
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
                            color: Color.fromRGBO(
                                255, 132, 0,
                                1), // Adjust the button color as needed
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors
                                .white, // Adjust the icon color as needed
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
                            color: Color.fromRGBO(
                                255, 132, 0,
                                1), // Adjust the button color as needed
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors
                                .white, // Adjust the icon color as needed
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCounterButton("-1", () {
              if(_timerSeconds - 1 < 0){
                return;
              }
              _timerSeconds -= 1;
              setState(() {});
            }),
            buildCounterButton("-5", () {
              if(_timerSeconds - 5 < 0){
                return;
              }
              _timerSeconds -= 5;
              setState(() {});
            }),
            buildCounterButton("-30", () {
              if(_timerSeconds - 30 < 0){
                return;
              }
              _timerSeconds -= 30;
              setState(() {});
            }),
          ],
        ),
        SizedBox(height: 20),
        buildStartTimerButton(),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCounterButton("+1", () {
              _timerSeconds += 1;
              setState(() {});
            }),
            buildCounterButton("+5", () {
              _timerSeconds += 5;
              setState(() {});
            }),
            buildCounterButton("+30", () {
              _timerSeconds += 30;
              setState(() {});
            }),
          ],
        ),
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
// Add your state and methods as needed
}

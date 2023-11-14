import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostPage extends StatefulWidget {
  PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Create Recipe', style: TextStyle(color: Colors.black)),
        actions: [postButton(context)],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Text('Name:'),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter the recipe name',
                      border: InputBorder.none,
                    ),
                  ))
                ],
              )),
          divider(),
          Column(
            children: [
              inputBox(context, 'Servings', 'Enter number of servings'),
              SizedBox(height: 10),
              inputBox(context, 'Est. Time', 'Enter the estimated time'),
            ],
          ),
          divider(),
          header('Ingredients'),
          inputBox(context, 'Add Ingredient', '')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text('Post'),
      ),
    );
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

  Widget inputBox(
      BuildContext context, String inputName, String inputDescription) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Text('$inputName :'),
            const SizedBox(width: 10),
            Expanded(
                child: TextFormField(
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

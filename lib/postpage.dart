import 'package:flutter/material.dart';

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
          title: const Text('Create Recipe',
              style: TextStyle(color: Colors.black))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 255, 255),
                    onPrimary: Colors.black,
                  ),
                  child: const Text('Post'),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Text('Name'),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter the recipe name',
                      border: InputBorder.none,
                    ),
                  ))
                ],
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Text('Post'),
      ),
    );
  }
}

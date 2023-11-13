import 'package:flutter/material.dart';

class NotifPage extends StatefulWidget {
  NotifPage({Key? key}) : super(key: key);

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // Center the title
        title: const Text(
          'Feast', // Display 'Feast' as the app bar title
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationItem('Alex followed you'),
          _buildNotificationItem('23 people liked your recipe'),
          _buildNotificationItem('Jane rated your recipe with 5 stars'),
          // Add more notification items as needed
        ],
      ),
    );
  }

  Widget _buildNotificationItem(String message) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          message,
          style: TextStyle(fontSize: 16.0),
        ),
        // You can customize the ListTile as needed
        // For example, you can add leading icons, trailing icons, etc.
        // leading: Icon(Icons.person),
        // trailing: Icon(Icons.arrow_forward),
        onTap: () {
          // Handle the tap on the notification
          // You can navigate to the relevant screen or perform any other action
          print('Notification tapped: $message');
        },
      ),
    );
  }
}

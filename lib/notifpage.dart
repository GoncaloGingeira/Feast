import 'package:flutter/material.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  List<String> notifications = [
    'Alex followed you',
    '23 people did your recipe',
    'Jane rated your recipe with 5 stars',
    'John commented your recipe',
  ];

  List<IconData> icons = [
    Icons.person,
    Icons.thumb_up,
    Icons.star,
    Icons.comment,
  ];

  List<bool> readNotifications = [false, false, true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'markAsRead') {
                setState(() {
                  readNotifications = [true, true, true, true];
                });
              } else if (value == 'deleteAll') {
                _deleteAllNotifications();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'markAsRead',
                child: Row(
                  children: [
                    Icon(Icons.done_all, color: Colors.green),
                    SizedBox(width: 8.0),
                    Text('Mark all as read',
                        style:
                            TextStyle(color: Color.fromARGB(255, 81, 35, 19))),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'deleteAll',
                child: Row(
                  children: [
                    Icon(Icons.delete_forever, color: Colors.red),
                    SizedBox(width: 8.0),
                    Text('Delete all',
                        style:
                            TextStyle(color: Color.fromARGB(255, 81, 35, 19))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildNoNotifications()
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                for (var i = 0; i < notifications.length; i++)
                  _buildNotificationItem(
                    notifications[i],
                    icons[i],
                    readNotifications[i] ? null : Colors.blue,
                  ),
              ],
            ),
    );
  }

  Widget _buildNotificationItem(
      String message, IconData icon, Color? dotColor) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 81, 35, 19),
              child: Icon(icon, color: Colors.white),
            ),
            if (dotColor != null)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          message,
          style: const TextStyle(
              fontSize: 16.0, color: Color.fromARGB(255, 81, 35, 19)),
        ),
        trailing: GestureDetector(
          onTap: () {
            _deleteNotification(message);
          },
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: const Icon(
              Icons.clear,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        onTap: () {
          // Handle the tap on the notification logic here
        },
      ),
    );
  }

  Widget _buildNoNotifications() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off,
              size: 60, color: Color.fromARGB(255, 81, 35, 19)),
          SizedBox(height: 16),
          Text(
            'No notifications!',
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 81, 35, 19),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteNotification(String notification) {
    setState(() {
      int index = notifications.indexOf(notification);
      notifications.remove(notification);
      readNotifications.removeAt(index);
      icons.removeAt(index);
    });
  }

  void _deleteAllNotifications() {
    setState(() {
      notifications.clear();
      readNotifications.clear();
      icons.clear();
    });
  }
}

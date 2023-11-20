import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Account Division
  bool privateAccount = true;

  // Push Notifications Division
  bool followsNotification = true;
  bool ratingsNotification = true;
  bool followerPostsNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(color: Color.fromARGB(255, 81, 35, 19))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 81, 35, 19),
              ),
            ),
            ListTile(
              leading: ClipOval(
                child: Image.asset(
                  'assets/avatar.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text(
                'Private Account',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              subtitle: const Text(
                'Make your account private',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              trailing: Switch(
                activeTrackColor: Color.fromARGB(255, 251, 227, 5),
                value: privateAccount,
                onChanged: (bool value) {
                  setState(() {
                    privateAccount = value;
                  });
                },
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 81, 35, 19),
            ),
            const Text(
              'Push Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 81, 35, 19),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add,
                  color: Color.fromARGB(255, 81, 35, 19)),
              title: const Text(
                'Follows',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              subtitle: const Text(
                'Receive new follows notifications',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              trailing: Switch(
                value: followsNotification,
                activeTrackColor: Color.fromARGB(255, 251, 227, 5),
                onChanged: (bool value) {
                  setState(() {
                    followsNotification = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.star,
                  color: Color.fromARGB(255, 81, 35, 19)),
              title: const Text(
                'Ratings',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              subtitle: const Text(
                'Receive ratings notifications',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              trailing: Switch(
                value: ratingsNotification,
                activeTrackColor: Color.fromARGB(255, 251, 227, 5),
                onChanged: (bool value) {
                  setState(() {
                    ratingsNotification = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu,
                  color: Color.fromARGB(255, 81, 35, 19)),
              title: const Text(
                'Follower\'s Posts',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              subtitle: const Text(
                'Receive new follower\'s recipes',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              trailing: Switch(
                value: followerPostsNotification,
                activeTrackColor: Color.fromARGB(255, 251, 227, 5),
                onChanged: (bool value) {
                  setState(() {
                    followerPostsNotification = value;
                  });
                },
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 81, 35, 19),
            ),
            const Text(
              'Help',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 81, 35, 19),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.help,
                  color: Color.fromARGB(255, 81, 35, 19)),
              title: const Text(
                'Visit our website',
                style: TextStyle(color: Color.fromARGB(255, 81, 35, 19)),
              ),
              onTap: () {
                print('Navigating to www.google.com');
              },
            ),
          ],
        ),
      ),
    );
  }
}

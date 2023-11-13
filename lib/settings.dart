import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Boxicons.bx_notification),
              title: Text('Notifications'),
              onTap: () {
                // Navigate to the Notifications settings
                // You can implement the specific settings page for Notifications here
                // For now, let's just print a message
                print('Navigate to Notifications settings');
              },
            ),
            ListTile(
              leading: Icon(Boxicons.bx_cog),
              title: Text('General'),
              onTap: () {
                // Navigate to the General settings
                // You can implement the specific settings page for General settings here
                // For now, let's just print a message
                print('Navigate to General settings');
              },
            ),
            ListTile(
              leading: Icon(Boxicons.bx_bell),
              title: Text('Sound'),
              onTap: () {
                // Navigate to the Sound settings
                // You can implement the specific settings page for Sound here
                // For now, let's just print a message
                print('Navigate to Sound settings');
              },
            ),
            // Add more ListTile widgets for additional settings options
          ],
        ),
      ),
    );
  }
}

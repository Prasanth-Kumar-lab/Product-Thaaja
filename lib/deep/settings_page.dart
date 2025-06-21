import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thaaja/deep/language.dart';
import 'package:thaaja/deep/password_manager.dart';
import 'package:thaaja/deep/t&c.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;  // State to control notifications switch

  // Method to handle the change in notification switch


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 0),
          Divider(
            color: Colors.grey[300],
            thickness: 1,
            indent: 15,
            endIndent: 20,
          ),
          ListTile(
            leading: Icon(Icons.sort_by_alpha, color: Colors.green),
            title: Text('Language'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'English',
                  style: TextStyle(fontSize: 15, color: Colors.green),
                ),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.green),
              ],
            ),
            onTap: () {
              Get.to(language()); // Navigate to the language settings page
            },
          ),
        ],
      ),
    );
  }
}

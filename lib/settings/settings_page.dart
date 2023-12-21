import 'package:flutter/material.dart';
import 'package:goodhearts/utils/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool commentsEnabled = true;
  bool sharingEnabled = true;
  bool autoplayEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Everyone can comment on your post'),
            trailing: Switch(
              value: commentsEnabled,
              onChanged: (newValue) {
                setState(() {
                  commentsEnabled = newValue;
                });
              },
              activeColor: appColor,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Everyone can share your post'),
            trailing: Switch(
              value: sharingEnabled,
              onChanged: (newValue) {
                setState(() {
                  sharingEnabled = newValue;
                });
              },
              activeColor: appColor,
            ),
          ),
          Divider(),
          ListTile(
            title: const Text('Autoplay of Audio and Video'),
            trailing: Switch(
              value: autoplayEnabled,
              onChanged: (newValue) {
                setState(() {
                  autoplayEnabled = newValue;
                });
              },
              activeColor: appColor,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsPage(),
  ));
}

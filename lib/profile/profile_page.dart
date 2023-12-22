import 'package:flutter/material.dart';
import 'package:goodhearts/profile/favorites_page.dart';
import 'package:goodhearts/authentication/login_page.dart';
import 'package:goodhearts/feed/myfeed_page.dart';
import 'package:goodhearts/profile/notification_page.dart';
import 'package:goodhearts/profile/recommendation_page.dart';
import 'package:goodhearts/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodhearts/profile/user_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _showLogoutConfirmationDialog() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: appColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: appColor),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(
              height: 1,
              thickness: 0.8,
              color: Colors.grey,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserProfilePage()),
                );
              },
              child: ListTile(
                leading: SvgPicture.asset(
                  'assets/profile.svg',
                  height: 32,
                  width: 32,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: Colors.black,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/myfeed.svg',
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              title: const Text('My Feed'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyFeedPage()),
                );
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: Colors.black,
              ),
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/fav.svg',
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoritesPage()),
                );
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: Colors.black,
              ),
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/recommendation.svg',
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              title: const Text('Recommendations'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Recommendation_Page()),
                );
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: Colors.black,
              ),
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/insights.svg',
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              title: const Text('Insights'),
              onTap: () {},
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: Colors.black,
              ),
            ),
            const Divider(),
            ListTile(
              leading: SvgPicture.asset(
                'assets/notification.svg',
                height: 25,
                width: 25,
                color: Colors.black,
              ),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const notification()),
                );
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 13,
                color: Colors.black,
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: appColor,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: appColor),
              ),
              onTap: () {
                _showLogoutConfirmationDialog();
              },
            ),
          ],
        ),
      ),
    );
  }
}

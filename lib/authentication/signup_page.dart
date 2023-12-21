import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodhearts/feed/feed_page.dart';
import 'package:goodhearts/utils/colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/logo.svg',
                        width: 70,
                        height: 68,
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Signup to post your good things',
                        style: TextStyle(
                            fontSize: 16,
                            color: appColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: buttonColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: buttonColor),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: screenWidth * 0.9,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: buttonColor),
                            ),
                          ),
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(height: 60),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileDetailsPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(34.09),
                            ),
                            backgroundColor: appColor,
                          ),
                          child: Container(
                            child: const Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontFamily: 'Poppins',
                              ),
                              children: [
                                const TextSpan(
                                  text: 'By Signing up you agree to our\n',
                                ),
                                TextSpan(
                                  text: 'Terms & Conditions',
                                  style: TextStyle(color: appColor),
                                ),
                                const TextSpan(
                                  text: ' & ',
                                ),
                                const TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Positioned(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  alignment: Alignment.bottomRight,
                  child: SvgPicture.asset(
                    'assets/signup.svg',
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                width: 70,
                height: 68,
              ),
              const SizedBox(height: 50),
              Text(
                'Enter your profile details',
                style: TextStyle(
                  fontSize: 16,
                  color: appColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 27),
              Center(
                child: SizedBox(
                  width: 380,
                  height: 60,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Name*',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              Container(
                width: 380,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: buttonColor),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedGender.isEmpty ? 'Gender' : selectedGender,
                      style: TextStyle(
                          color: selectedGender.isEmpty
                              ? Colors.grey
                              : Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        _openGenderSelection(context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: 380,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Country*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: 380,
                height: 60,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 17),
              SizedBox(
                width: 380,
                height: 60,
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number*',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: buttonColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(width: 377, height: 60),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34.09),
                    ),
                    backgroundColor: appColor,
                  ),
                  child: Container(
                    child: const Center(
                      child: Text(
                        'Save Profile',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Container(
                  child: Center(
                child: SvgPicture.asset(
                  'assets/saveprofile.svg',
                  width: 181.66,
                  height: 149.84,
                ),
              ))
            ],
          ),
        ),
      ),
    ));
  }

  void _openGenderSelection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Gender'),
          content: SizedBox(
            width: screenWidth * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Male'),
                  onTap: () {
                    setState(() {
                      selectedGender = 'Male';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Female'),
                  onTap: () {
                    setState(() {
                      selectedGender = 'Female';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Transgender'),
                  onTap: () {
                    setState(() {
                      selectedGender = 'Transgender';
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: const Text('Preferred not to say'),
                  onTap: () {
                    setState(() {
                      selectedGender = 'Preferred not to say';
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

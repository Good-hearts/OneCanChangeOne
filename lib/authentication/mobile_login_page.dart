import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goodhearts/utils/colors.dart';
import 'login_page.dart';
import 'otp_page.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  _PhoneNumberPageState createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 40.0),
                    Container(
                      child: SvgPicture.asset(
                        'assets/logo.svg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    Container(
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              TextSpan(
                                text: 'We will send you a ',
                              ),
                              TextSpan(
                                text: 'One Time Password \t',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'to \n your mobile number\n',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: buttonColor,
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: screenWidth * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: IntlPhoneField(
                                    controller: phoneNumberController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter mobile number',
                                      border: InputBorder.none,
                                    ),
                                    initialCountryCode: 'US',
                                    onChanged: (phone) {
                                      print(phone.completeNumber);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          String fullPhoneNumber = phoneNumberController.text;
                          print('Verifying OTP for $fullPhoneNumber');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OtpPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34.09),
                          ),
                          minimumSize: const Size(377, 63),
                        ),
                        child: const Text(
                          'Get OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 250),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Go Back?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      'assets/otp_1.svg',
                      width: 248,
                      height: 194,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(10.0),
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }
}


import 'package:shared_preferences/shared_preferences.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/login_screen.dart';
import '../utils/app_size.dart';
import '../utils/app_styles.dart';

class SettingsPrincipal extends StatefulWidget {
  const SettingsPrincipal({super.key});

  @override
  State<SettingsPrincipal> createState() => _SettingsPrincipalState();
}

class _SettingsPrincipalState extends State<SettingsPrincipal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Settings',
            style: Styles.headLineStyle2.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: AppSize.getWidth(27.0, context),
            ),
          ),
          // You can customize the AppBar further as needed
        ),
        body: SafeArea(
          child: Container(
            color: Color(0xfff8f3f3),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: AppSize.getHeight(22, context),
                    horizontal: AppSize.getWidth(22, context),
                  ),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: AppSize.getHeight(33, context),
                            height: AppSize.getHeight(33, context),
                            child: Image.asset("assets/images/edit_details.png"),
                          ),
                          SizedBox(
                            width: AppSize.getWidth(12, context),
                          ),
                          Expanded(
                            child: Text(
                              "Edit details",
                              style: Styles.headLineStyle2.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Perform logout operation here
                    // For example, you can show a confirmation dialog and then logout
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.pop(context);

                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform logout operation
                              // For example, you can navigate to the login screen
                              // or call a logout function
                              // Here, we simply pop the settings screen for demonstration
                              Navigator.pop(context); // Close the dialog
                              startLogout(context); // Pop the settings screen
                            },
                            child: Text("Logout"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: AppSize.getHeight(22, context),
                      horizontal: AppSize.getWidth(22, context),
                    ),
                    child: Wrap(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: AppSize.getHeight(40, context),
                              height: AppSize.getHeight(40, context),
                              child: Image.asset("assets/images/logout.png"),
                            ),
                            SizedBox(
                              width: AppSize.getWidth(12, context),
                            ),
                            Expanded(
                              child: Text(
                                "Logout",
                                style: Styles.headLineStyle2.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void sendToLoginScreen(BuildContext context) {
  //   // Use pushReplacement to navigate to the main screen and remove the splash screen from the navigation stack
  //
  //   setState(() {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               LoginScreen()), // Replace with your main screen
  //     );
  //   });
  // }
  void sendToLoginScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false, // Disable any route popping, keep only the login screen
    );
  }



  Future<void> clearPreferences() async {
    // Replace this with the actual code to clear preferences
    // For example, if pref is an instance of SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  Future<void> startLogout(BuildContext context) async {
    try {
      await clearPreferences();
      sendToLoginScreen(context); // Pass context to sendToLoginScreen
    } catch (error) {
      print('Error clearing preferences: $error');
    }
  }
}

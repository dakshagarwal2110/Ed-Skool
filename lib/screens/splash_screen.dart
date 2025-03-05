import 'package:ed_skool/screens/login_screen.dart';
import 'package:ed_skool/screens/principal_main_screen.dart';
import 'package:ed_skool/utils/app_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Add any initialization logic here if needed

    // Use a Future.delayed to wait for a certain duration
    Future.delayed(Duration(seconds: 3), () {

      openNextScreen(context);
    });

    return Scaffold(
      body:
            Container(

              color: Colors.black,

              child: Center(
                child: Container(
                  decoration: BoxDecoration(

                      image: DecorationImage(
                        image: AssetImage("assets/images/splash_logo.png"),
                        fit: BoxFit.fill,
                      )),
                  height: AppSize.getHeight(300, context),
                  width: AppSize.getWidth(300, context),
                ), // Replace with your splash screen content
              ),

            ),


    );
  }

  Future<void> openNextScreen(BuildContext context) async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    if ((preferences.getString('entry_type') ?? "") == "Principal") {
      if ((preferences.getString('code') ?? "") != "" &&
          (preferences.getString('admission_id') ?? "") != "" &&
          (preferences.getString('school_name') ?? "") != "" &&
          (preferences.getString('profile_image') ?? "") != "" &&
          (preferences.getString('entry_type') ?? "") != "" &&
          (preferences.getString('name') ?? "")!="" &&
          (preferences.getString('classroom') ?? "")!=""){
        sendToPrincipalMainScreen(context);
      } else {
        preferences.clear();
        sendToLoginScreen(context);
      }
    }else if ((preferences.getString('entry_type') ?? "") == "Teacher"){
      //TeacherMainScreen();

    }
    else{
      sendToLoginScreen(context);
    }

  }

  void sendToPrincipalMainScreen(BuildContext context) {
    print("int ittt");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PrincipalMainScreen(),
      ),
    );

  }

  void sendToLoginScreen(BuildContext context) {

    // Use pushReplacement to navigate to the main screen and remove the splash screen from the navigation stack
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              LoginScreen()), // Replace with your main screen
    );

  }


}

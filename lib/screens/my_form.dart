import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:ed_skool/screens/about_us_activity.dart';
import 'package:ed_skool/screens/explore_activity.dart';
import 'package:ed_skool/screens/principal_main_screen.dart';
import 'package:ed_skool/single_layouts/card_text_image_login_screen.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/app_size.dart';
import '../utils/outlined_text_feild.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});
  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController admissionIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController schoolCodeController = TextEditingController();
  String password = "";
  String code = "";
  String admissionId = "";
  bool isButtonVisible = true;
  bool isProgressBarVisible = false;
  var data;


  @override
  Widget build(BuildContext context) {
    return
      ListView(children: [
      SizedBox(
        height: AppSize.getHeight(16, context),
      ),
      Row(
        children: [
          SizedBox(
            width: AppSize.getWidth(10, context),
          ),
          Container(
              margin: EdgeInsets.only(top: AppSize.getHeight(25.0, context)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.getWidth(30.0, context))),
                  color: Colors.transparent),
              alignment: Alignment.center,
              child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: AppSize.getWidth(24.0, context),
                  ))),
          SizedBox(
            width: AppSize.getWidth(15, context),
          ),
          Container(
              margin: EdgeInsets.only(top: AppSize.getHeight(25.0, context)),
              child: Text("Ed-Skool",
                  style: Styles.headLineStyle2.copyWith(color: Colors.white))),
          Spacer(),
          Container(
            margin: EdgeInsets.only(
                top: AppSize.getHeight(21, context),
                right: AppSize.getWidth(7, context)),
            height: AppSize.getHeight(42, context),
            width: AppSize.getWidth(42, context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/info.png"))),
          ),
        ],
      ),
      SizedBox(
        height: AppSize.getHeight(40, context),
      ),
      Container(
        height: AppSize.getScreenHeight(context),
        padding: EdgeInsets.only(
            right: AppSize.getWidth(16, context),
            left: AppSize.getWidth(16, context)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.getWidth(30, context)),
              topRight: Radius.circular(AppSize.getWidth(30, context))),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppSize.getHeight(20, context)),
            Text(
              "Welcome back!",
              style: Styles.headLineStyle1.copyWith(color: Colors.black),
            ),
            SizedBox(height: AppSize.getHeight(8, context)),
            Text(
              "Hello there sign in to continue,",
              style: Styles.headLineStyle4.copyWith(color: Color(0xff4f4949)),
            ),
            SizedBox(height: AppSize.getHeight(25, context)),
            OutlinedTextField(
              labelText: 'School Code',
              hintText: 'Enter school code',
              keyboardType: TextInputType.number,
              controller: schoolCodeController,
            ),
            SizedBox(
              height: AppSize.getHeight(15, context),
            ),

            OutlinedTextField(
              labelText: 'Admission ID',
              hintText: 'Enter Admission ID',
              keyboardType: TextInputType.text,
              controller: admissionIdController,
            ),
            SizedBox(
              height: AppSize.getHeight(15, context),
            ),
            OutlinedTextField(
              labelText: 'Password',
              hintText: 'Enter password',
              keyboardType: TextInputType.text,
              controller: passwordController,
            ),
            SizedBox(
              height: AppSize.getHeight(15, context),
            ),
            Visibility(
              visible: isButtonVisible,
              child: ElevatedButton(
                onPressed: () async {
                  bool isAvailable = await isNetworkAvailable();
                  if (isAvailable) {
                    if (validateCode() &&
                        validateAdmissionId() &&
                        validatePassword()) {
                      setState(() {
                        isButtonVisible = false;
                        isProgressBarVisible = true;
                      });

                      startLoginValidation();
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Network error!"),
                    ));
                  }
                },


                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF01012D),  // Set your desired button color here
                  elevation: AppSize.getWidth(18, context),
                  shadowColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.getWidth(22, context),
                    vertical: AppSize.getHeight(8, context),
                  ),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: AppSize.getWidth(17, context),
                  ),
                ),
              ),
            ),

            // SizedBox(height: AppSize.getHeight(5, context)),
            // Margin bottom equivalent
            Center(
              child: Visibility(
                visible: isProgressBarVisible,
                // Set the initial visibility as needed
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme
                        .of(context)
                        .primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.getHeight(9, context)),

            Container(
              width: AppSize.getScreenWidth(context),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExploreActivity()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: AppSize.getWidth(0, context),
                        shadowColor: Colors.black,
                      ),
                      child: CardTextImageLoginScreen(
                        imageToShow: "assets/images/explore.png",
                        textToShow: "Explore",
                      ),
                    ),
                  ),
                  SizedBox(width: AppSize.getWidth(16, context)),
                  // Adjust the spacing
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const About_Us_Activity()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: AppSize.getWidth(0, context),
                        shadowColor: Colors.black,
                      ),
                      child: CardTextImageLoginScreen(
                        imageToShow: "assets/images/team.png",
                        textToShow: "Who are we?",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Add other form fields or buttons as needed
          ],
        ),
      )
    ]);
  }


  void startLoginValidation() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Schools')
          .doc(code)
          .collection("school_ids")
          .doc(admissionId)
          .get();
      //print(code+"--"+admissionId);
      if (snapshot.exists) {
        data = snapshot.data();
        String passwordInstance = data['password'];

        if (passwordInstance == password) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Authentication successful"),
          ));

          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString('code', code);
          preferences.setString('admission_id', admissionId);
          preferences.setString('school_name', data['school_name']);
          preferences.setString('profile_image', data['profile_image']);
          preferences.setString('entry_type', data['entry_type']);
          preferences.setString('name', data['Name']);
          preferences.setString('classroom', data['classroom']);

          String entryType = data['entry_type'];

          if (entryType == "Principal") {
            print("User is a Principal");
            sendToPrincipalMainScreen(context);
          } else {
            print("User is not a Principal");
            // Handle navigation for other entry types if needed
          }

          setState(() {
            isButtonVisible = true;
            isProgressBarVisible = false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Invalid password!"),
          ));

          setState(() {
            isButtonVisible = true;
            isProgressBarVisible = false;
          });
        }
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid ID!"),
        ));
        setState(() {
          isButtonVisible = true;
          isProgressBarVisible = false;
        });
      }
    } catch (e) {
      //print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error occurred!"),
      ));
      setState(() {
        isButtonVisible = true;
        isProgressBarVisible = false;
      });
    }
  }

  Future<bool> isNetworkAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    return false;
  }

  bool validatePassword() {
    password = passwordController.text.trim();
    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password cannot be empty!"),
      ));
      return false;
    } else if (password.length < 3) {
      // Password too short
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Password too short!"),
      ));
      return false;
    } else {
      // Password is valid
      return true;
    }
  }

  bool validateCode() {
    code = schoolCodeController.text.trim();
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Code cannot be empty!"),
      ));
      return false;
    } else {
      // Password is valid
      return true;
    }
  }

  bool validateAdmissionId() {
    admissionId = admissionIdController.text.trim();
    if (admissionId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("ID cannot be empty!"),
      ));
      return false;
    } else if (admissionId.length < 2) {
      // Password too short
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Id too short!"),
      ));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Id too short!'),
        ),
      );
      return false;
    } else {
      // Password is valid
      return true;
    }
  }


  @override
  void initState() {
    super.initState();
    checkUserPreferences();
  }

  void checkUserPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if ((preferences.getString('entry_type') ?? "") == "Principal") {
      if ((preferences.getString('code') ?? "") != "" &&
          (preferences.getString('admission_id') ?? "") != "" &&
          (preferences.getString('school_name') ?? "") != "" &&
          (preferences.getString('profile_image') ?? "") != "" &&
          (preferences.getString('entry_type') ?? "") != "" &&
          (preferences.getString('name') ?? "") != "" &&
          (preferences.getString('classroom') ?? "") != "") {
        sendToPrincipalMainScreen(context);
      } else if ((preferences.getString('name') ?? "") == "Teacher") {
        //TeacherMainScreen();
      }
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
  @override
  void dispose() {
    print("bhai onDespose mu form called");
    // This method is called when the widget is removed from the widget tree
    // Perform cleanup or resource release here

    super.dispose();
  }


}


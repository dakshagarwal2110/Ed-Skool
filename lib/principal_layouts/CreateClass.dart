import 'package:connectivity/connectivity.dart';
import 'package:ed_skool/utils/app_size.dart';
import 'package:ed_skool/utils/outlined_text_feild.dart';
import 'package:ed_skool/utils/top_back_arrow_and_heading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/app_styles.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  TextEditingController classNameController = TextEditingController();
  TextEditingController classTeacherNameController = TextEditingController();
  TextEditingController classTeacherEmailController = TextEditingController();
  TextEditingController classTeacherPasswordController =
      TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  bool isButtonVisible = true;
  bool isProgressBarVisible = false;
  String class_name = "";
  String class_teacher_name = "";
  String login_id = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        body: Material(
          child: SafeArea(
              child: Container(
            color: const Color(0xff01012d),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular((AppSize.getWidth(4, context))),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes the shadow position
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.getWidth(16, context),
                      vertical: AppSize.getHeight(15, context)),
                  child:Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSize.getWidth(0, context),vertical: AppSize.getHeight(0, context)),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular((AppSize.getWidth(4, context))),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes the shadow position
                                ),
                              ],
                            ),
                            child: Center(
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: AppSize.getWidth(24.0, context),
                                  ),
                                ))),
                        SizedBox(width: AppSize.getWidth(18, context),),
                        Text(
                          "Create class",
                          style: Styles.headLineStyle2
                              .copyWith(color: Colors.black, fontWeight: FontWeight.bold , decoration: TextDecoration.none),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: AppSize.getHeight(12, context)),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(AppSize.getWidth(24, context)),
                          topLeft:
                              Radius.circular(AppSize.getWidth(24, context))),
                      color: Colors.white,
                    ),
                    margin:
                        EdgeInsets.only(top: AppSize.getHeight(12, context)),
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.getWidth(17, context)),
                    child: ListView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: AppSize.getHeight(30, context),
                          ),
                          OutlinedTextField(
                              labelText: "Class name",
                              hintText: "Class name",
                              keyboardType: TextInputType.text,
                              controller: classNameController),
                          SizedBox(
                            height: AppSize.getHeight(17, context),
                          ),
                          OutlinedTextField(
                              labelText: "Class teacher name",
                              hintText: "Class teacher name",
                              keyboardType: TextInputType.text,
                              controller: classTeacherNameController),
                          SizedBox(
                            height: AppSize.getHeight(17, context),
                          ),
                          OutlinedTextField(
                              labelText: "Class teacher login ID",
                              hintText: "Class teacher login ID",
                              keyboardType: TextInputType.text,
                              controller: classTeacherEmailController),
                          SizedBox(
                            height: AppSize.getHeight(17, context),
                          ),
                          OutlinedTextField(
                              labelText: "Class teacher password",
                              hintText: "Class teacher password",
                              keyboardType: TextInputType.text,
                              controller: classTeacherPasswordController),
                          SizedBox(
                            height: AppSize.getHeight(17, context),
                          ),

                          Visibility(
                            visible: isButtonVisible,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool isAvailable = await isNetworkAvailable();

                                if (isAvailable) {
                                  if (validateClassName() &&
                                      validateTeacherName() &&
                                      validateAdmissionId() &&
                                      validatePassword()) {
                                    setState(() {
                                      isButtonVisible = false;
                                      isProgressBarVisible = true;
                                    });

                                    startUploadingData();
                                  }
                                } else {
                                  scaffoldMessengerKey.currentState
                                      ?.showSnackBar(
                                    const SnackBar(
                                      content: Text("Network error!"),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF01012D),
                                // Set your desired button color here
                                elevation: AppSize.getWidth(18, context),
                                shadowColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppSize.getWidth(22, context),
                                  vertical: AppSize.getHeight(8, context),
                                ),
                              ),
                              child: Text(
                                "Create class",
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
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  bool validateClassName() {
    class_name = classNameController.text.trim();
    if (class_name.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Class name cannot be empty!"),
        ),
      );
      return false;
    } else {
      // Password is valid
      return true;
    }
  }

  bool validateTeacherName() {
    class_teacher_name = classTeacherNameController.text.trim();
    if (class_teacher_name.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Teacher name cannot be empty!"),
        ),
      );
      return false;
    } else {
      // Password is valid
      return true;
    }
  }

  bool validateAdmissionId() {
    login_id = classTeacherEmailController.text.trim();
    if (login_id.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("ID cannot be empty!"),
        ),
      );

      return false;
    } else {
      // Password is valid
      return true;
    }
  }

  bool validatePassword() {
    password = classTeacherPasswordController.text.trim();
    if (password.isEmpty) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Password cannot be empty!"),
        ),
      );
      return false;
    } else {
      // Password is valid
      return true;
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

  Future<void> startUploadingData() async {
    // scaffoldMessengerKey.currentState?.showSnackBar(
    //   const SnackBar(
    //     content: Text("Data upload started"),
    //   ),
    // );
    SharedPreferences preferences = await SharedPreferences.getInstance();

    CollectionReference allSchoolsCollection =
        FirebaseFirestore.instance.collection("Schools");
    DocumentSnapshot teacherDoc = await allSchoolsCollection
        .doc(preferences.getString('code'))
        .collection("school_ids")
        .doc(login_id)
        .get();

    CollectionReference allClassroomsCollection =
        FirebaseFirestore.instance.collection("Schools");
    DocumentSnapshot classDoc = await allClassroomsCollection
        .doc(preferences.getString('code'))
        .collection("All classes")
        .doc(class_name)
        .get();

    if (classDoc.exists) {
      // Teacher email exists
      // Perform the actions when email exists

      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content:
              Text("Classroom already exists!"),
        ),
      );

      setState(() {
        isButtonVisible = true;
        isProgressBarVisible = false;
      });
    } else {
      // Teacher email does not exist
      // Perform the actions when email does not exist

      if (teacherDoc.exists) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          const SnackBar(
            content: Text("This email is already linked with a teacher of a class"),
          ),
        );
        setState(() {
          isButtonVisible = true;
          isProgressBarVisible = false;
        });
      } else {

        // scaffoldMessengerKey.currentState?.showSnackBar(
        //   const SnackBar(
        //     content: Text("Please wait!"),
        //   ),
        // );

        String teacherEmail = login_id;
        String teacherName = class_teacher_name;
        String teacherPassword = password;

        String? schoolName = preferences.getString('school_name');
        String nonNullableSchoolName = schoolName ?? "xyz";

        String? schoolCode = preferences.getString('code');
        String nonNullableSchoolCode = schoolCode ?? "101";

        String imageUri =
            "https://firebasestorage.googleapis.com/v0/b/myfirebaseapp-73558.appspot.com/o/user_no_profile_image.png?alt=media&token=c6ab381a-ab3c-48e1-a4fa-995e5eeb385e";
        String className = class_name;

        // Creating map1
        Map<String, Object> map1 = {
          "id": teacherEmail,
          "Name": teacherName,
          "password": teacherPassword,
          "school_name": nonNullableSchoolName,
          "profile_image": imageUri,
          "classroom": className,
          "code": nonNullableSchoolCode,
          "entry_type":"Teacher"
        };

        // Creating map2
        Map<String, Object> map2 = {
          "id": teacherEmail,
          "Name": teacherName,
          "classroom": className,
          "code": nonNullableSchoolCode,
          "school_name": nonNullableSchoolName,
        };

        // Creating map3
        Map<String, Object> map3 = {
          "classroom": className,
        };

        CollectionReference allSchoolsCollection =
            FirebaseFirestore.instance.collection("Schools");

        try {
          await allSchoolsCollection
              .doc(nonNullableSchoolCode)
              .collection("school_ids")
              .doc(teacherEmail)
              .set(map1);

          await allSchoolsCollection
              .doc(nonNullableSchoolCode)
              .collection("Classrooms")
              .doc(className)
              .collection("classroom data")
              .doc("teacher details")
              .set(map2);

          await allSchoolsCollection
              .doc(nonNullableSchoolCode)
              .collection("All classes")
              .doc(className)
              .set(map3);

          setState(() {
            isButtonVisible = true;
            isProgressBarVisible = false;
            classTeacherPasswordController.text='';
            classTeacherNameController.text='';
            classTeacherEmailController.text='';
            classNameController.text='';

          });

          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text("Classroom successfully created!"),
            ),
          );


          // You can add UI updates here if needed
        } catch (e) {
          // Handle errors
          setState(() {
            isButtonVisible = true;
            isProgressBarVisible = false;
          });

          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text("Error occurred!"),
            ),
          );

        }
      }
    }
  }
  @override
  void dispose() {
    // Perform cleanup tasks here, similar to onDestroy in Android

    // Don't forget to call super.dispose() to free up resources
    super.dispose();
  }
}

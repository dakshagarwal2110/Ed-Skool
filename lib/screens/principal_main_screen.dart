import 'package:ed_skool/principal_layouts/announcement_principal.dart';
import 'package:ed_skool/principal_layouts/settings_principal.dart';
import 'package:ed_skool/screens/contact_us.dart';
import 'package:ed_skool/single_layouts/card_text_image_main_screens.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../principal_layouts/CreateClass.dart';
import '../principal_layouts/all_classes.dart';
import '../utils/app_size.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrincipalMainScreen extends StatefulWidget {
  const PrincipalMainScreen({super.key});

  @override
  State<PrincipalMainScreen> createState() => _PrincipalMainScreenState();
}

class _PrincipalMainScreenState extends State<PrincipalMainScreen> {
  String title = "";
  String entrytype = "";
  bool dataComplete = false;

  Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Container(
              color: Colors.white70,
              padding: EdgeInsets.only(
                  right: AppSize.getWidth(12, context),
                  left: AppSize.getWidth(12, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppSize.getHeight(12, context),
                  ),
                  Text(title,
                      style: Styles.headLineStyle2.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  Text(entrytype,
                      style: Styles.headLineStyle3.copyWith(
                          color: Colors.purple, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: AppSize.getHeight(10, context),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  startLogout();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation: MaterialStateProperty.all<double>(
                                      AppSize.getWidth(5, context)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                child: CardTextImageMainScreens(
                                  imageToShow:
                                      "assets/images/notification_bell.png",
                                  textToShow: "Notification",
                                ),
                              ),
                            ),
                            SizedBox(width: AppSize.getWidth(16, context)),
                            // Adjust the spacing
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // bool x= checkUserPreferencesBoolean();
                                  if (await checkUserPreferencesBoolean()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateClass(),
                                      ),
                                    );
                                  } else {
                                    startLogout();

                                    // sendToLoginScreen(context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation: MaterialStateProperty.all<double>(
                                      AppSize.getWidth(5, context)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                child: CardTextImageMainScreens(
                                  imageToShow: "assets/images/classroom.png",
                                  textToShow: "Create class",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.getHeight(18, context),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  // bool x= checkUserPreferencesBoolean();
                                  if (await checkUserPreferencesBoolean()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            LazyLoadingWidget(),
                                      ),
                                    );
                                  } else {
                                    startLogout();

                                    // sendToLoginScreen(context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation: MaterialStateProperty.all<double>(
                                      AppSize.getWidth(5, context)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                child: CardTextImageMainScreens(
                                  imageToShow: "assets/images/all_class.png",
                                  textToShow: "All classes",
                                ),
                              ),
                            ),
                            SizedBox(width: AppSize.getWidth(16, context)),
                            // Adjust the spacing
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (await checkUserPreferencesBoolean()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AnnouncementPrincipal(),
                                      ),
                                    );
                                  } else {
                                    startLogout();

                                    // sendToLoginScreen(context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation: MaterialStateProperty.all<double>(
                                      AppSize.getWidth(5, context)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                child: CardTextImageMainScreens(
                                  imageToShow: "assets/images/announcement.png",
                                  textToShow: "Announcement",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.getHeight(18, context),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SettingsPrincipal(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation: MaterialStateProperty.all<double>(
                                      AppSize.getWidth(5, context)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                child: CardTextImageMainScreens(
                                  imageToShow: "assets/images/settings.png",
                                  textToShow: "Settings",
                                ),
                              ),
                            ),
                            SizedBox(width: AppSize.getWidth(16, context)),
                            // Adjust the spacing
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  elevation: MaterialStateProperty.all<double>(
                                      AppSize.getWidth(5, context)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20.0), // Adjust the radius as needed
                                    ),
                                  ),
                                ),
                                child: CardTextImageMainScreens(
                                  imageToShow: "assets/images/explore.png",
                                  textToShow: "About school",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.getHeight(18, context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactUs(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                elevation: MaterialStateProperty.all<double>(
                                    AppSize.getWidth(5, context)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the radius as needed
                                  ),
                                ),
                              ),
                              child: CardTextImageMainScreens(
                                imageToShow: "assets/images/contact_us.png",
                                textToShow: "Contact us",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void sendToLoginScreen(BuildContext context) {
    // Use pushReplacement to navigate to the main screen and remove the splash screen from the navigation stack

    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // Replace with your main screen
      );
    });
  }

  Future<void> clearPreferences() async {
    // Replace this with the actual code to clear preferences
    // For example, if pref is an instance of SharedPreferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  Future<void> startLogout() async {
    try {
      await clearPreferences();
      // Preferences have been cleared, now send to login screen
      sendToLoginScreen(context);
    } catch (error) {
      print('Error clearing preferences: $error');
    }
  }

  void getTitle() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      title = (preferences.getString('name') ?? "");
      entrytype = (preferences.getString('entry_type') ?? "");

      print("principal name is $title");
      print("principal class is $entrytype");
    });
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
        startLogout();
      } else {
        setState(() {
          dataComplete = true;
        });
      }
    }
  }

  Future<bool> checkUserPreferencesBoolean() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String entryType = preferences.getString('entry_type') ?? "";

    if (entryType == "Principal") {
      return (preferences.getString('code') ?? "") != "" &&
          (preferences.getString('admission_id') ?? "") != "" &&
          (preferences.getString('school_name') ?? "") != "" &&
          (preferences.getString('profile_image') ?? "") != "" &&
          (entryType != "") &&
          (preferences.getString('name') ?? "") != "" &&
          (preferences.getString('classroom') ?? "") != "";
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTitle();
  }

  @override
  void dispose() {
    // Perform cleanup tasks here, similar to onDestroy in Android

    print("principal disposed");
    // Don't forget to call super.dispose() to free up resources
    super.dispose();
  }
}

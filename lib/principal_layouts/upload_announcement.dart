import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:ed_skool/utils/add_data_to_storage.dart';
import 'package:ed_skool/utils/outlined_text_feild.dart';
import 'package:ed_skool/utils/pick_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../utils/app_size.dart';
import '../utils/app_styles.dart';

class UploadAnnouncement extends StatefulWidget {
  const UploadAnnouncement({super.key});

  @override
  State<UploadAnnouncement> createState() => _UploadAnnouncementState();
}

class _UploadAnnouncementState extends State<UploadAnnouncement> {
  Uint8List? image;
  TextEditingController addDetailsController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool isVisibleImageBox = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: scaffoldMessengerKey,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add announcement',
              style: Styles.headLineStyle2.copyWith(color: Colors.black),
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
          body: ListView(
            children: [
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffe6e6ef),
                        // Specify the color of the border (blue in this case)
                        width: 1.0, // Specify the width of the border
                      ),
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: AppSize.getWidth(2, context)),
                    // Ensure the container takes the entire width available
                    child: image != null
                        ? Visibility(
                            visible: isVisibleImageBox,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                image!,
                                width: double.infinity,
                                // Expand the image to fill the container width
                                height: AppSize.getHeight(380, context),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )
                        : Visibility(
                            visible: false, // Set to false to hide the widget
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppSize.getWidth(8, context)),
                              child: Image.asset(
                                "assets/images/classroom_photo1.png",
                                width: double.infinity,
                                height: AppSize.getHeight(480, context),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          )),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: AppSize.getWidth(12, context),
                    right: AppSize.getWidth(12, context),
                    top: AppSize.getHeight(5, context)),
                child: ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff01012d),
                    elevation: AppSize.getWidth(18, context),
                    shadowColor: Colors.black,
                  ),
                  child: Text(
                    "Pick Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSize.getWidth(17, context),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: AppSize.getWidth(12, context),
                    right: AppSize.getWidth(12, context),
                    top: AppSize.getHeight(12, context)),
                child: OutlinedTextField(
                    labelText: "Add details",
                    hintText: "Add details",
                    keyboardType: TextInputType.text,
                    controller: addDetailsController),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: AppSize.getWidth(12, context),
                    right: AppSize.getWidth(12, context)),
                child: ElevatedButton(
                  onPressed: uploadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff01012d),
                    elevation: AppSize.getWidth(18, context),
                    shadowColor: Colors.black,
                  ),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSize.getWidth(17, context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _pickImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      image = img;
      isVisibleImageBox = true;
    });
  }

  void uploadData() async {
    hideSoftKeyboard(context);
    bool networkAvailable = await isNetworkAvailable();
    int time = DateTime.now().millisecondsSinceEpoch;
    String timeInString = time.toString();

    if (networkAvailable) {

      if(image==null){

        final progressDialog = ProgressDialog(context: context);
        progressDialog.show(
          max: 100,
          msg: 'Uploading data...',
          backgroundColor: Colors.white,
          borderRadius: 10.0,
          elevation: 10.0,
          barrierDismissible: false,
        );

        String resp = await AddDataToStorage()
            .saveDataWithoutImage(caption: addDetailsController.text , time: timeInString);

        print("whoooowowo $resp");

        if (resp == 'Success') {
          setState(() {
            image = null;
            isVisibleImageBox = false;
            addDetailsController.text = "";
          });

          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text("Announcement uploaded"),
            ),
          );
        } else {
          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text("Error occurred!"),
            ),
          );
        }
        setState(() {
          progressDialog.close();
        });
      }else{

        //Agar image null nahi hai...
        final progressDialog = ProgressDialog(context: context);
        progressDialog.show(
          max: 100,
          msg: 'Uploading data...',
          backgroundColor: Colors.white,
          borderRadius: 10.0,
          elevation: 10.0,
          barrierDismissible: false,
        );

        String resp = await AddDataToStorage()
            .saveData(caption: addDetailsController.text, file: image!, time: timeInString);

        print("whoooowowo $resp");

        if (resp == 'Success') {
          setState(() {
            image = null;
            isVisibleImageBox = false;
            addDetailsController.text = "";
          });

          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text("Announcement uploaded"),
            ),
          );
        } else {
          scaffoldMessengerKey.currentState?.showSnackBar(
            const SnackBar(
              content: Text("Error occurred!"),
            ),
          );
        }
        setState(() {
          progressDialog.close();
        });
      }

    } else {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(
          content: Text("Network error!"),
        ),
      );
    }
  }

  void hideSoftKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
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
}

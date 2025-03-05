import 'package:ed_skool/utils/app_size.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact Ed-Skool',
            style: Styles.headLineStyle2.copyWith(color: Colors.black ,fontWeight: FontWeight.w600),
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
                      horizontal: AppSize.getWidth(22, context)),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Wrap(
                            children: [
                              Container(
                                width: AppSize.getHeight(33, context),
                                height: AppSize.getHeight(33, context),
                                child: Image.asset("assets/images/mail.png"),
                              )
                            ],
                          ),
                          SizedBox(
                            width: AppSize.getWidth(12, context),
                          ),
                          Expanded(
                              child: Text(
                            "edskool07@gmail.com",
                            style: Styles.headLineStyle2.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          )),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(const ClipboardData(
                                        text: "edskool07@gmail.com"))
                                    .then((_) {
                                  scaffoldMessengerKey.currentState?.showSnackBar(
                                    const SnackBar(
                                      content: Text("Mail copied"),
                                    ),
                                  );
                                });
                              },
                              icon: Icon(Icons.copy))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: AppSize.getHeight(22, context),
                      horizontal: AppSize.getWidth(22, context)),
                  child: Wrap(
                    children: [
                      Row(
                        children: [
                          Wrap(
                            children: [
                              Container(
                                width: AppSize.getHeight(40, context),
                                height: AppSize.getHeight(40, context),
                                child: Image.asset("assets/images/whatsapp.png"),
                              )
                            ],
                          ),
                          SizedBox(
                            width: AppSize.getWidth(12, context),
                          ),
                          Expanded(
                              child: Text(
                                "9412729195",
                                style: Styles.headLineStyle2.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              )),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(const ClipboardData(
                                    text: "9412729195"))
                                    .then((_) {
                                  scaffoldMessengerKey.currentState?.showSnackBar(
                                    const SnackBar(
                                      content: Text("Number copied"),
                                    ),
                                  );
                                });
                              },
                              icon: Icon(Icons.copy))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:ed_skool/principal_layouts/upload_announcement.dart';
import 'package:ed_skool/screens/announcements_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';
import '../utils/app_styles.dart';

class AnnouncementPrincipal extends StatefulWidget {
  const AnnouncementPrincipal({super.key});

  @override
  State<AnnouncementPrincipal> createState() => _AnnouncementPrincipalState();
}

class _AnnouncementPrincipalState extends State<AnnouncementPrincipal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Announcements',
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
          actions: [
            Padding(
              padding: EdgeInsets.all(AppSize.getWidth(6, context)),
              child: Material(
                elevation: 4.0, // Adjust elevation as needed
                borderRadius: BorderRadius.circular(AppSize.getWidth(10, context)), // Adjust border radius as needed
                color: Colors.white, // Adjust color as needed
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UploadAnnouncement(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: AppSize.getWidth(25.0, context),
                  ),
                ),
              ),
            ),
          ],
          // You can customize the AppBar further as needed
        ),
        body: AnnouncementsFetch(), // Add your body widget here
      ),
    );
  }
}

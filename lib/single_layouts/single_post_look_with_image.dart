import 'package:ed_skool/utils/app_size.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstagramPost extends StatelessWidget {
  final String urlString;
  final String caption;
  final String date;
  final String imageIdentifier;


  const InstagramPost({
    required this.urlString,
    required this.caption,
    required this.date,
    required this.imageIdentifier,
  });

  @override
  Widget build(BuildContext context) {
    int milliseconds = int.parse(date);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    String dateFinal = DateFormat('dd MMMM yyyy hh:mm a').format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: AppSize.getHeight(420, context),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffe6e6ef),
                // Specify the color of the border (blue in this case)
                width: 1.0, // Specify the width of the border
              ),
            ),


          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.getWidth(14, context)),
                    child: ClipOval(
                      child: Image.asset(
                        imageIdentifier,
                        fit: BoxFit.cover,
                        width: AppSize.getWidth(30, context), // Adjust the width as needed
                        height: AppSize.getHeight(30, context), // Adjust the height as needed
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.getWidth(2, context)),
                    child: Text(
                        "@Principal",
                        style: Styles.headLineStyle2.copyWith(color: Colors.black , fontWeight: FontWeight.w600)
                    ),
                  ),
                ],
              ),



              Padding(
                padding: EdgeInsets.only(left: AppSize.getWidth(16, context) , top: AppSize.getHeight(5, context)),
                child: Text(
                  caption,
                  style: Styles.headLineStyle3.copyWith(color: Colors.black , fontWeight: FontWeight.w500)
                ),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.getWidth(13, context)), // Adjust the radius as needed
                    child: Image.network(
                      urlString,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.getWidth(16, context) , vertical: AppSize.getHeight(8, context)),
                child: Text(
                    dateFinal,
                    style: Styles.headLineStyle3.copyWith(color: Colors.black , fontWeight: FontWeight.w400)
                ),
              ),
            ],
          )
        ),

      ],
    );
  }
}

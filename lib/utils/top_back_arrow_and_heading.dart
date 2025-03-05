import 'package:ed_skool/utils/app_size.dart';
import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopBackArrowAndHeading extends StatelessWidget {
  String textToShow;

  TopBackArrowAndHeading({super.key, required this.textToShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSize.getWidth(9, context),vertical: AppSize.getHeight(5, context)),
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
                  child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: AppSize.getWidth(24.0, context),
              ))),
          SizedBox(width: AppSize.getWidth(18, context),),
          Text(
            textToShow,
            style: Styles.headLineStyle2
                .copyWith(color: Colors.black, fontWeight: FontWeight.bold , decoration: TextDecoration.none),
          )
        ],
      ),
    );
  }
}

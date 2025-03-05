import 'dart:io';

import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';

class CardTextImageLoginScreen extends StatelessWidget {
  final String imageToShow;
  String textToShow;

  CardTextImageLoginScreen(
      {super.key, required this.textToShow, required this.imageToShow});

  @override
  Widget build(BuildContext context) {
    return
      Center(
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.getWidth(12.0, context)),
            //margin: EdgeInsets.only(right: AppSize.getWidth(25 , context), left: AppSize.getWidth(25,context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.getWidth(25.0, context))),
                color: Color(0xFF01012D)),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: AppSize.getHeight(18, context),
                      bottom: AppSize.getHeight(10, context)),
                  height: AppSize.getHeight(42, context),
                  width: AppSize.getWidth(42, context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset(imageToShow).image)),
                ),
                Container(
                    margin: EdgeInsets.only(right: AppSize.getWidth(6 , context), left: AppSize.getWidth(6 , context), bottom: AppSize.getHeight(13 , context)),
                    child: Text(
                      textToShow,
                      style: Styles.headLineStyle2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

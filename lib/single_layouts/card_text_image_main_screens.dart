import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_size.dart';
import '../utils/app_styles.dart';

class CardTextImageMainScreens extends StatelessWidget {

  final String imageToShow;
  String textToShow;
  CardTextImageMainScreens({super.key, required this.textToShow, required this.imageToShow});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.getWidth(4.0, context)),
            //margin: EdgeInsets.only(right: AppSize.getWidth(25 , context), left: AppSize.getWidth(25,context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.getWidth(4.0, context))),
                color: Colors.white),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: AppSize.getHeight(6, context),
                      bottom: AppSize.getHeight(4, context)),
                  height: AppSize.getHeight(52, context),
                  width: AppSize.getWidth(52, context),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset(imageToShow).image)),
                ),
                Container(
                    margin: EdgeInsets.only(right: AppSize.getWidth(6 , context), left: AppSize.getWidth(6 , context), bottom: AppSize.getHeight(13 , context)),
                    child: Text(
                      textToShow,
                      style: Styles.headLineStyle4.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:ed_skool/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About_Us_Activity extends StatelessWidget {
  const About_Us_Activity({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("About us",style: Styles.headLineStyle2.copyWith(color: Colors.white),)
    );
  }
}

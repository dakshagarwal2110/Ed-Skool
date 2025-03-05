import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_styles.dart';

class ExploreActivity extends StatelessWidget {
  const ExploreActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Text("Explore",style: Styles.headLineStyle2.copyWith(color: Colors.white),)
    );
  }
}

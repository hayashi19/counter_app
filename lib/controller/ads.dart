// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ADS extends StatelessWidget {
  AdWithView ad;
  ADS({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 250,
      child: AdWidget(ad: ad),
    );
  }
}

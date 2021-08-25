import 'package:flutter/material.dart';


  // function
  double card(BuildContext context) {
      var width = MediaQuery.of(context).size.width;
      return width < 700 ? width  : width < 1200 ? width * 0.60 : width * 0.30;
 }

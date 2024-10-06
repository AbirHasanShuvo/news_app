import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

const spinKit2 = SpinKitFadingCircle(
  size: 50,
  color: Colors.amber,
);

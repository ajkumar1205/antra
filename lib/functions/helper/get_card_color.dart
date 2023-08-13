import 'dart:math';

import 'package:flutter/material.dart';

import '../../constants/color_list.constant.dart';

Color getColor() {
  Random rand = Random();
  return colors[rand.nextInt(10)];
}

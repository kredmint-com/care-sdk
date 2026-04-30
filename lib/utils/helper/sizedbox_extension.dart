import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  SizedBox get h => SizedBox(height: toDouble()); // Usage: 20.h
  SizedBox get w => SizedBox(width: toDouble());  // Usage: 20.w
}
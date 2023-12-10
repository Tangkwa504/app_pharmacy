import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static const TextStyle txtHeader1 = TextStyle(
    color: AppColor.themeTextColor,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle txtHeader2 = TextStyle(
    color: AppColor.themeTextColor,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle txtHeader3 = TextStyle(
    color: AppColor.themeTextColor,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static const TextStyle txtBody = TextStyle(
    color: AppColor.themeTextColor,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static const TextStyle txtBody2 = TextStyle(
    color: AppColor.themeTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle txtCaption = TextStyle(
    color: AppColor.themeTextColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
  );

  static const TextStyle txtError = TextStyle(
    color: AppColor.errorColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: 1.33,
  );
}

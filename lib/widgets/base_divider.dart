import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:flutter/material.dart';

class BaseDivider extends StatelessWidget {
  final double top, bottom;
  const BaseDivider({
    super.key,
    this.top = 4,
    this.bottom = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: top, bottom: bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.themeGrayLight,
      ),
    );
  }
}

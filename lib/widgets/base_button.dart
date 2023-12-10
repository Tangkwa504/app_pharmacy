import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color? bgColor;
  final bool isEnabled;
  final double? width;

  const BaseButton({
    super.key,
    required this.onTap,
    required this.label,
    this.bgColor,
    this.isEnabled = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final minWidth = width ?? 100.0;
    final _bgColor = bgColor ?? AppColor.themePrimaryColor;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        constraints: BoxConstraints(
          minWidth: minWidth,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isEnabled ? _bgColor : AppColor.themeGrayLight,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppStyle.txtBody.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Widget prefixImg;
  final String label;

  const ProfileMenuWidget({
    super.key,
    required this.onTap,
    required this.prefixImg,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          prefixImg,
          Expanded(
            child: Text(
              label,
              style: AppStyle.txtBody,
            ),
          ),
          Assets.icRight.svg(),
        ],
      ),
    );
  }
}

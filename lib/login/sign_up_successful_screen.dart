import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/generated/assets.gen.dart';
import 'package:app_pharmacy/login/login_screen.dart';
import 'package:app_pharmacy/menu/home_screen.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:app_pharmacy/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class SignUpSuccessfulScreen extends StatelessWidget {
  static const routeName = 'SignUpSuccessfulScreen';

  const SignUpSuccessfulScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return
    return BaseScaffold(
      bodyBuilder: (context, constriant) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icDone.svg(),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'ทำการสมัครเรียบร้อย!!!',
                style: AppStyle.txtHeader3,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'รอแอดมินอนุมัติเพื่อดำเนินการต่อ',
                style: AppStyle.txtBody2.copyWith(
                  color: AppColor.themeGrayLight,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              BaseButton(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                    (route) => false,
                  );
                },
                label: 'ยืนยัน',
              ),
            ],
          ),
        );
      },
    );
  }
}

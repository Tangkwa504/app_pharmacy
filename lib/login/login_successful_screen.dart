import 'package:app_pharmacy/generated/assets.gen.dart';
import 'package:app_pharmacy/menu/home_screen.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:app_pharmacy/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';

class LoginSuccessfulScreen extends StatelessWidget {
  static const routeName = 'LoginSuccessfulScreen';

  final HomeScreenArgs args;

  const LoginSuccessfulScreen({
    super.key,
    required this.args,
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
              const Text('ทำการเข้าสู่ระบบเรียบร้อย'),
              const SizedBox(
                height: 24,
              ),
              BaseButton(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    arguments: HomeScreenArgs(id: args.id),
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

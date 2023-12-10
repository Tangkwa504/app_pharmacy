import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/first_page.dart';
import 'package:app_pharmacy/profile/bloc/profile_bloc.dart';
import 'package:app_pharmacy/profile/profile_page.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:app_pharmacy/widgets/base_dialog.dart';
import 'package:app_pharmacy/widgets/base_scaffold.dart';
import 'package:app_pharmacy/widgets/base_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = 'ChangePasswordScreen';

  final ProfileArgs args;

  const ChangePasswordScreen({
    super.key,
    required this.args,
  });

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final oldPassword = widget.args.profileInformation?.password;

    return BaseScaffold(
      isLoading: context.watch<ProfileBloc>().state.isLoading,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      bodyBuilder: (context, constraint) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "เปลี่ยนรหัสผ่าน",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                BaseTextField(
                  isObscure: true,
                  controller: newPassword,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 243, 16, 72),
                  ),
                  hint: 'New Password',
                ),
                const SizedBox(height: 12),
                BaseTextField(
                  isObscure: true,
                  controller: confirmPassword,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 243, 16, 72),
                  ),
                  hint: 'Confirm Password',
                ),
                const SizedBox(height: 12),
                BaseButton(
                  width: MediaQuery.of(context).size.width,
                  onTap: () async {
                    if (newPassword.text.isEmpty ||
                        confirmPassword.text.isEmpty) {
                      await showBaseDialog(
                        context: context,
                        builder: (ctx) {
                          return BaseDialog(
                            message: 'กรุณากรอก Password',
                          );
                        },
                      );
                      return;
                    }

                    if (oldPassword == newPassword.text) {
                      // ignore: use_build_context_synchronously
                      await showBaseDialog(
                        context: context,
                        builder: (ctx) {
                          return BaseDialog(
                            message: 'Password ตรงกับของเดิม',
                          );
                        },
                      );
                      return;
                    }

                    if (newPassword.text != confirmPassword.text) {
                      // ignore: use_build_context_synchronously
                      await showBaseDialog(
                        context: context,
                        builder: (ctx) {
                          return BaseDialog(
                            message: 'Password ไม่ตรงกัน',
                          );
                        },
                      );
                      return;
                    }

                    final result = await context
                        .read<ProfileBloc>()
                        .changePassword(newPassword.text);

                    if (result) {
                      Fluttertoast.showToast(
                        msg: "Update Success",
                        gravity: ToastGravity.TOP,
                      );

                      Navigator.of(context).pop();
                    }
                  },
                  label: 'ยืนยัน',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

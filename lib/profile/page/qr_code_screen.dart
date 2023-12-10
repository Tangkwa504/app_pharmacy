import 'dart:io';

import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/profile/bloc/profile_bloc.dart';
import 'package:app_pharmacy/profile/profile_page.dart';
import 'package:app_pharmacy/utils/image_picker/image_picker_provider.dart';
import 'package:app_pharmacy/utils/image_picker/model/image_picker_config_request.dart';
import 'package:app_pharmacy/utils/util/base_permission_handler.dart';
import 'package:app_pharmacy/widgets/base_app_bar.dart';
import 'package:app_pharmacy/widgets/base_button.dart';
import 'package:app_pharmacy/widgets/base_dialog.dart';
import 'package:app_pharmacy/widgets/base_image_view.dart';
import 'package:app_pharmacy/widgets/base_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class QRCodeScreen extends StatefulWidget {
  static const String routeName = 'QRCodeScreen';
  final ProfileArgs args;

  const QRCodeScreen({
    super.key,
    required this.args,
  });

  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  XFile? qrCode;

  @override
  Widget build(BuildContext context) {
    final qrCodeUrl = widget.args.profileInformation?.imgQRCode;
    return BaseScaffold(
      isLoading: context.watch<ProfileBloc>().state.isLoading,
      appBar: const BaseAppBar(
        title: Text(
          'แก้ไข QRCode',
          style: AppStyle.txtHeader2,
        ),
        bgColor: AppColor.themGraySoftLight,
      ),
      bodyBuilder: (context, constrained) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (qrCode != null) ...[
                BaseImageView(
                  file: File(qrCode!.path),
                  fit: BoxFit.cover,
                  height: 250,
                  width: 250,
                ),
              ] else ...[
                BaseImageView(
                  url: qrCodeUrl,
                  fit: BoxFit.cover,
                  height: 250,
                  width: 250,
                ),
              ],
              const Spacer(),
              BaseButton(
                bgColor: AppColor.themeYellowColor,
                width: MediaQuery.of(context).size.width,
                onTap: () async {
                  const maxFileSizeInBytes = 2 *
                      1048576; // 2MB (You'll probably want this outside of this function so you can reuse the value elsewhere)

                  final isGrant =
                      await BasePermissionHandler.requestStoragePermission();
                  if (isGrant) {
                    final result = await ImagePickerUtils.getImage(
                      const ImagePickerConfigRequest(
                        source: ImageSource.gallery,
                        maxHeight: 1920,
                        maxWidth: 2560,
                        imageQuality: 30,
                      ),
                    );

                    if (result[0] != null) {
                      final imagePath = await result[0]!.readAsBytes();
                      final fileSize = imagePath.length;
                      if (fileSize <= maxFileSizeInBytes) {
                        setState(() {
                          qrCode = result[0];
                        });
                      } else {
                        // ignore: use_build_context_synchronously
                        await showBaseDialog(
                          context: context,
                          builder: (ctx) {
                            return BaseDialog(
                              message: 'ไฟล์ขนาดใหญ่เกิน 2 MB',
                            );
                          },
                        );
                      }
                    }
                  }
                },
                label: 'อัปโหลดรูป',
              ),
              const SizedBox(
                height: 16,
              ),
              BaseButton(
                width: MediaQuery.of(context).size.width,
                onTap: () async {
                  final result =
                      await context.read<ProfileBloc>().updateQRCode(qrCode);
                  if (result) {
                    Fluttertoast.showToast(
                      msg: "Update Success",
                      gravity: ToastGravity.TOP,
                    );
                  }
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

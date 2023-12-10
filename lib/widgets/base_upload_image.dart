import 'package:app_pharmacy/core/style/app_color.dart';
import 'package:app_pharmacy/core/style/app_style.dart';
import 'package:app_pharmacy/utils/image_picker/image_picker_provider.dart';
import 'package:app_pharmacy/utils/image_picker/model/image_picker_config_request.dart';
import 'package:app_pharmacy/utils/util/base_permission_handler.dart';
import 'package:app_pharmacy/widgets/base_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BaseUploadImage extends StatefulWidget {
  final String? filePath;
  final String label;
  final ImageSource source;
  final Function(XFile? file) onUpload;

  const BaseUploadImage({
    super.key,
    required this.label,
    this.filePath,
    this.source = ImageSource.gallery,
    required this.onUpload,
  });

  @override
  _BaseUploadImageState createState() => _BaseUploadImageState();
}

class _BaseUploadImageState extends State<BaseUploadImage> {
  String path = '';

  @override
  Widget build(BuildContext context) {
    final label = widget.label;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.txtBody2.copyWith(
            color: AppColor.themeGrayLight,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChooseFileWidget(
                    source: widget.source,
                    onUpload: (file) {
                      setState(() {
                        path = file?.path ?? '';
                      });
                      widget.onUpload(file);
                    },
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      path.isNotEmpty ? path : 'No file choosen',
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.txtBody2.copyWith(
                        color: AppColor.themeGrayLight,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '(ไฟล์ .jpg,gif,png ไม่เกิน 2mb)',
                style: AppStyle.txtBody2.copyWith(
                  color: AppColor.themeGrayLight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChooseFileWidget extends StatelessWidget {
  final Function(XFile? file) onUpload;
  final ImageSource source;

  const ChooseFileWidget({
    super.key,
    required this.onUpload,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        const maxFileSizeInBytes = 2 *
            1048576; // 2MB (You'll probably want this outside of this function so you can reuse the value elsewhere)

        final isGrant = await BasePermissionHandler.requestStoragePermission();
        if (isGrant) {
          final result = await ImagePickerUtils.getImage(
            ImagePickerConfigRequest(
              source: source,
              maxHeight: 1920,
              maxWidth: 2560,
              imageQuality: 30,
            ),
          );

          if (result[0] != null) {
            final imagePath = await result[0]!.readAsBytes();
            final fileSize = imagePath.length;
            if (fileSize <= maxFileSizeInBytes) {
              onUpload(result[0]);
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
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.themePrimaryColor,
        ),
        child: Text(
          'Choose',
          textAlign: TextAlign.center,
          style: AppStyle.txtBody.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

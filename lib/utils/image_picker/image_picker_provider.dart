import 'dart:io';

import 'package:app_pharmacy/utils/image_picker/enum/image_picker_type_enum.dart';
import 'package:app_pharmacy/utils/image_picker/model/image_picker_config_request.dart';
import 'package:app_pharmacy/utils/util/base_utils.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  ImagePickerUtils._();

  static ImagePicker get imagePicker => ImagePicker();

  static Future<List<XFile?>> getImage(ImagePickerConfigRequest request) async {
    try {
      final _allowFileExtension = ['.jpg', '.png'];
      final type = request.type;
      final source = request.source;
      final maxWidth = request.maxWidth;
      final maxHeight = request.maxHeight;
      final imageQuality = request.imageQuality;

      List<XFile?> picker = [];
      if (type == ImagePickerType.signle) {
        final result = await imagePicker.pickImage(
          source: source,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
        );

        if (result != null) {
          if (!BaseUtils.allowFileExtension(result.path, _allowFileExtension)) {
            return [];
          }
        }

        picker.add(result);
      } else {
        picker = await imagePicker.pickMultiImage(
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          imageQuality: imageQuality,
        );

        if (picker.isNotEmpty) {
          for (final item in picker) {
            if (!BaseUtils.allowFileExtension(
              item!.path,
              _allowFileExtension,
            )) {
              return [];
            }
          }
        }
      }
      if (Platform.isAndroid) {
        final response = await imagePicker.retrieveLostData();

        final List<XFile>? files = response.files;
        if (files != null) {
          return files;
        }
      }

      final res = picker;
      return res;
    } catch (e) {
      print(e);
    }
    return [];
  }
}

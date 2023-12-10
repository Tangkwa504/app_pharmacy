import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

class UpdateQRCodeRequest {
  final XFile file;
  final String id;

  UpdateQRCodeRequest({
    required this.id,
    required this.file,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file': file,
    };
  }
}

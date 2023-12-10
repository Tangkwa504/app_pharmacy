import 'package:app_pharmacy/utils/image_picker/enum/image_picker_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_config_request.freezed.dart';
part 'image_picker_config_request.g.dart';

@immutable
@freezed
class ImagePickerConfigRequest with _$ImagePickerConfigRequest {
  const factory ImagePickerConfigRequest({
    @Default(ImagePickerType.signle) ImagePickerType type,
    @Default(ImageSource.gallery) ImageSource source,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) = _ImagePickerConfigRequest;

  factory ImagePickerConfigRequest.fromJson(Map<String, dynamic> json) =>
      _$ImagePickerConfigRequestFromJson(json);
}
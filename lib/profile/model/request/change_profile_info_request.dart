import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfileInfoRequest {
  final XFile profileImg;
  final XFile licenseImg;
  final String id;
  final String name;
  final String tel;
  final String licensePharmacy;
  final String email;

  ChangeProfileInfoRequest({
    required this.id,
    required this.profileImg,
    required this.licenseImg,
    required this.name,
    required this.tel,
    required this.licensePharmacy,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profileImg': profileImg,
      'licenseImg': licenseImg,
      'name': name,
      'tel': tel,
      'licensePharmacy': licensePharmacy,
      'email': email,
    };
  }
}

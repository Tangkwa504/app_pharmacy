import 'package:app_pharmacy/profile/enum/phamarcy_status_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_information_response.freezed.dart';
part 'profile_information_response.g.dart';

@immutable
@freezed
abstract class ProfileInformationResponse with _$ProfileInformationResponse {
  @JsonSerializable()
  const factory ProfileInformationResponse({
    required String addressShop,
    required String email,
    required String id,
    required String licensePharmacy,
    required String name,
    required String nameShop,
    required String password,
    required String telNumber,
    required String timeClosing,
    required String timeOpening,
    required String imgLicenseStoreUrl,
    required String imgLicenseUrl,
    required String imgQRCode,
    required double latitude,
    required double longitude,
    required PhamarcyStatus status,
    required String profileImgUrl,
  }) = _ProfileInformationResponse;

  factory ProfileInformationResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileInformationResponseFromJson(json);
}

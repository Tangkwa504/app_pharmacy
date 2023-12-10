import 'package:app_pharmacy/profile/model/response/profile_information_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    ProfileInformationResponse? profileInformation,
    @Default(false) bool isLoading,
  }) = _ProfileState;
}

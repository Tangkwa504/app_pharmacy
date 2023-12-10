import 'package:app_pharmacy/core/local_storage/base_shared_preference.dart';
import 'package:app_pharmacy/profile/bloc/state/profile_state.dart';
import 'package:app_pharmacy/profile/model/request/change_password_request.dart';
import 'package:app_pharmacy/profile/model/request/change_profile_info_request.dart';
import 'package:app_pharmacy/profile/model/request/update_qr_code_request.dart';
import 'package:app_pharmacy/profile/usecase/change_password_usecase.dart';
import 'package:app_pharmacy/profile/usecase/change_profile_info_usecase.dart';
import 'package:app_pharmacy/profile/usecase/read_profile_information_usecase.dart';
import 'package:app_pharmacy/profile/usecase/update_qr_code_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileBloc extends Cubit<ProfileState> {
  final UpdateQRCodeUsecase _updateQRCodeUsecase;
  final ReadProfileInformationUseCase _readProfileInformationUseCase;
  final BaseSharedPreference _baseSharedPreference;
  final ChangePasswordUsecase _changePasswordUsecase;
  final ChangeProfileInfoUsecase _changeProfileInfoUsecase;

  ProfileBloc(
    this._updateQRCodeUsecase,
    this._readProfileInformationUseCase,
    this._baseSharedPreference,
    this._changePasswordUsecase,
    this._changeProfileInfoUsecase,
  ) : super(const ProfileState());

  void onGetProfileInformation() async {
    final id = _baseSharedPreference.getString(BaseSharePreferenceKey.id);

    if (id == null) return;

    final result = await _readProfileInformationUseCase.execute(id);

    result.when(
      (success) {
        emit(
          state.copyWith(
            profileInformation: success,
          ),
        );
      },
      (error) => null,
    );
  }

  Future<bool> updateQRCode(XFile? file) async {
    emit(state.copyWith(isLoading: true));
    bool isSuccess = false;
    final id = _baseSharedPreference.getString(BaseSharePreferenceKey.id);

    if (id == null || file == null) return false;

    final result = await _updateQRCodeUsecase.execute(
      UpdateQRCodeRequest(
        id: id,
        file: file,
      ),
    );

    result.when(
      (success) => isSuccess = success,
      (error) => null,
    );

    emit(state.copyWith(isLoading: false));

    return isSuccess;
  }

  Future<bool> changePassword(String password) async {
    emit(state.copyWith(isLoading: true));

    bool isSuccess = false;
    final id = _baseSharedPreference.getString(BaseSharePreferenceKey.id);

    if (id == null) return false;

    final result = await _changePasswordUsecase.execute(
      ChangePasswordRequest(
        id: id,
        password: password,
      ),
    );

    result.when(
      (success) => isSuccess = success,
      (error) => null,
    );

    emit(state.copyWith(isLoading: false));

    return isSuccess;
  }

  Future<bool> changeProfileInfo(ChangeProfileInfoRequest request) async {
    emit(state.copyWith(isLoading: true));

    bool isSuccess = false;
    final id = _baseSharedPreference.getString(BaseSharePreferenceKey.id);

    if (id == null) return false;

    final result = await _changeProfileInfoUsecase.execute(request);

    result.when(
      (success) => isSuccess = success,
      (error) => null,
    );

    emit(state.copyWith(isLoading: false));

    return isSuccess;
  }
}

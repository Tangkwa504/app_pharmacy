// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_pharmacy/core/cache/base_custom_cache_manager.dart' as _i4;
import 'package:app_pharmacy/core/get_it/register_module.dart' as _i16;
import 'package:app_pharmacy/core/local_storage/base_shared_preference.dart'
    as _i14;
import 'package:app_pharmacy/core/route/app_navigator.dart' as _i3;
import 'package:app_pharmacy/login/bloc/authentication_bloc.dart' as _i13;
import 'package:app_pharmacy/login/usecase/upload_licenses_phamarcy_store_usecase.dart'
    as _i10;
import 'package:app_pharmacy/login/usecase/upload_licenses_phamarcy_usecase.dart'
    as _i11;
import 'package:app_pharmacy/login/usecase/upload_qr_code_usecase.dart' as _i12;
import 'package:app_pharmacy/profile/bloc/profile_bloc.dart' as _i15;
import 'package:app_pharmacy/profile/usecase/change_password_usecase.dart'
    as _i5;
import 'package:app_pharmacy/profile/usecase/change_profile_info_usecase.dart'
    as _i6;
import 'package:app_pharmacy/profile/usecase/read_profile_information_usecase.dart'
    as _i7;
import 'package:app_pharmacy/profile/usecase/update_qr_code_usecase.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singleton<_i3.AppNavigator>(_i3.AppNavigator());
    gh.singleton<_i4.BaseCustomCacheManager>(_i4.BaseCustomCacheManager());
    gh.factory<_i5.ChangePasswordUsecase>(() => _i5.ChangePasswordUsecase());
    gh.factory<_i6.ChangeProfileInfoUsecase>(
        () => _i6.ChangeProfileInfoUsecase());
    gh.factory<_i7.ReadProfileInformationUseCase>(
        () => _i7.ReadProfileInformationUseCase());
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i9.UpdateQRCodeUsecase>(() => _i9.UpdateQRCodeUsecase());
    gh.factory<_i10.UploadLicensesPhamarcyStoreUsecase>(
        () => _i10.UploadLicensesPhamarcyStoreUsecase());
    gh.factory<_i11.UploadLicensesPhamarcyUsecase>(
        () => _i11.UploadLicensesPhamarcyUsecase());
    gh.factory<_i12.UploadQRCodeUsecase>(() => _i12.UploadQRCodeUsecase());
    gh.factory<_i13.AuthenticationBloc>(() => _i13.AuthenticationBloc(
          gh<_i11.UploadLicensesPhamarcyUsecase>(),
          gh<_i10.UploadLicensesPhamarcyStoreUsecase>(),
          gh<_i12.UploadQRCodeUsecase>(),
        ));
    gh.singleton<_i14.BaseSharedPreference>(
        _i14.BaseSharedPreference(gh<_i8.SharedPreferences>()));
    gh.factory<_i15.ProfileBloc>(() => _i15.ProfileBloc(
          gh<_i9.UpdateQRCodeUsecase>(),
          gh<_i7.ReadProfileInformationUseCase>(),
          gh<_i14.BaseSharedPreference>(),
          gh<_i5.ChangePasswordUsecase>(),
          gh<_i6.ChangeProfileInfoUsecase>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i16.RegisterModule {}

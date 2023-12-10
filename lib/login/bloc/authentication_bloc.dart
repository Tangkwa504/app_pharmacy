import 'package:app_pharmacy/login/usecase/upload_licenses_phamarcy_store_usecase.dart';
import 'package:app_pharmacy/login/usecase/upload_licenses_phamarcy_usecase.dart';
import 'package:app_pharmacy/login/usecase/upload_qr_code_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthenticationBloc extends Cubit<bool> {
  final UploadLicensesPhamarcyUsecase _uploadLicensesPhamarcyUsecase;
  final UploadLicensesPhamarcyStoreUsecase _uploadLicensesPhamarcyStoreUsecase;
  final UploadQRCodeUsecase _uploadQRCodeUsecase;

  AuthenticationBloc(
    this._uploadLicensesPhamarcyUsecase,
    this._uploadLicensesPhamarcyStoreUsecase,
    this._uploadQRCodeUsecase,
  ) : super(false);

  Future<String> uploadLicensesPhamarcy(XFile? file) async {
    String url = "";

    if (file == null) return "";

    final result = await _uploadLicensesPhamarcyUsecase.execute(file);

    result.when((success) => url = success, (error) => null);

    return url;
  }

  Future<String> uploadLicensesPhamarcyStore(XFile? file) async {
    String url = "";

    if (file == null) return "";

    final result = await _uploadLicensesPhamarcyStoreUsecase.execute(file);

    result.when((success) => url = success, (error) => null);

    return url;
  }

  Future<String> uploadQRCode(XFile? file) async {
    String url = "";

    if (file == null) return "";

    final result = await _uploadQRCodeUsecase.execute(file);

    result.when((success) => url = success, (error) => null);

    return url;
  }
}

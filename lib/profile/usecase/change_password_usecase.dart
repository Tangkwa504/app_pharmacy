import 'dart:async';
import 'package:app_pharmacy/core/application/usecase.dart';
import 'package:app_pharmacy/core/firebase/firebase_realtime/firebase_realtime_provider.dart';
import 'package:app_pharmacy/profile/model/request/change_password_request.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUsecase extends UseCase<ChangePasswordRequest, bool> {
  ChangePasswordUsecase();

  @override
  Future<bool> exec(ChangePasswordRequest request) async {
    try {
      final collection = FirebaseRealtimeProvider.ref('Pharmacy/${request.id}');

      await collection.update({
        'Password': request.password,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}

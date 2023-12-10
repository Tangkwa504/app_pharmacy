import 'package:app_pharmacy/core/application/failure.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class UseCase<P, R> {
  @protected
  Future<R> exec(P request);

  Future<Result<R, Failure>> execute(P request) async {
    try {
      final result = await exec(request);
      return Success(result);
    } on FirebaseException catch (e) {
      return Error(
        Failure(
          message: e.message ?? '',
        ),
      );
    }
  }
}

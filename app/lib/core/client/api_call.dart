// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:logger/logger.dart';

import '../errors/failure.dart';

T? cast<T>(dynamic x) => x is T ? x : null;

/// Function for mapping api call into either success or failure.
Future<Either<Failure, T>> apiCall<T>(Future<T> t) async {
  try {
    final futureCall = await t;
    return Right(futureCall);
  } on DioError catch (e) {
    Logger().wtf(e.error.runtimeType);
    Logger().wtf(e.error.toString());
    if (e.error is ArgumentError) {
      final error = cast<ArgumentError>(e.error);
      return Left(GeneralFailure(message: error?.message.toString()));
    } else if (e.error is SocketException) {
      Logger().e('Error: No Internet Connection');
      return Left(NetworkFailure(message: 'No Internet Connection'));
    } else if (e.error is TimeoutException) {
      Logger().e('Error: Timeout');
      return Left(TimeoutFailure());
    } else if (e.error is FormatException) {
      Logger().e('Error: Format from front end error');
      return Left(GeneralFailure(message: 'Format Exception'));
    } else if ((e.response?.statusCode ?? 0) == 403) {
      Logger().e('Unauthorized');
      return Left(GeneralFailure(message: 'Unauthorize'));
    } else if ((e.response?.statusCode ?? 0) == 404) {
      Logger().e('Not Found Failure');
      return Left(
        NotFoundFailure(
          message: cast<String>(e.response?.data['message']) ?? 'Not Found',
        ),
      );
    } else {
      final message = DioFailure.fromDioError(e).message;
      return Left(GeneralFailure(message: message));
    }
  } catch (e) {
    Logger().e(e.toString());
    Logger().e(e.runtimeType);
    if (e is TypeError) {
      return Left(GeneralFailure(message: 'Type Error occured'));
    }

    ///case error FrontEnd Service
    return Left(GeneralFailure(message: e.toString()));
  }
}

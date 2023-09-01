// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';

abstract class Failure implements Exception {
  Failure({
    this.title,
    this.code,
    this.message,
  });

  String? title;

  // provide error status code
  String? code;

  /// error message
  String? message;
}

class DioFailure implements Exception {
  DioFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.sendTimeout:
        message = 'Send timeout in connection with API server';
        break;
      case DioErrorType.receiveTimeout:
        message = 'Connection timeout with API server';
        break;
      case DioErrorType.badCertificate:
        message = 'Incorrect configuration certificate';
        break;
      case DioErrorType.badResponse:
        message = _handleResponseError(dioError.response!);
        break;
      case DioErrorType.cancel:
        message = 'Request to API server was cancelled';
        break;
      case DioErrorType.connectionError:
        message = 'Connection error with API server';
        break;
      case DioErrorType.unknown:
        message = dioError.toString();
        break;
    }
  }

  String message = 'Request failed, please try again or contact admin';

  String _handleResponseError(Response<dynamic> res) {
    var errorMessage = message;

    if (res.data['message'] != null) {
      errorMessage = res.data['message'].toString();
    }

    return errorMessage;
  }

  @override
  String toString() => message;
}

class NetworkFailure extends Failure {
  NetworkFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Network Failure',
        );
}

class NotFoundFailure extends Failure {
  NotFoundFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Not Found Failure',
        );
}

class BadRequestFailure extends Failure {
  BadRequestFailure({
    super.code,
    super.message,
  }) : super(
          title: 'Bad Request Failure',
        );
}

class GeneralFailure extends Failure {
  GeneralFailure({
    super.message,
  }) : super(
          title: 'General Failure',
        );
}

class TimeoutFailure extends Failure {
  TimeoutFailure({
    super.message,
  }) : super(
          title: 'Timeout Failure',
        );
}

class ArgumentFailure extends Failure {
  ArgumentFailure({
    super.message,
  }) : super(
          title: 'Argument Failure',
        );
}

class UnAuthorizeFailure extends Failure {
  UnAuthorizeFailure({
    super.message,
  }) : super(
          title: 'UnAuthorize Failure',
        );
}

class ParseFailure extends Failure {}

class EmptyFailure extends Failure {}

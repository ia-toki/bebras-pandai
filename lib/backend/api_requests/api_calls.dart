import 'dart:convert';
import 'dart:typed_data';

import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetCategoriesCall {
  static Future<ApiCallResponse> call({
    int? count = 4,
    int? offset = 0,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'getCategories',
      apiUrl: 'https://jservice.io/api/categories',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'count': count,
        'offset': offset,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class CategoryCall {
  static Future<ApiCallResponse> call({
    int? id,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'category',
      apiUrl: 'https://jservice.io/api/category',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'id': id,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class QuestionCall {
  static Future<ApiCallResponse> call({
    int? category,
    int? value,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'question',
      apiUrl: 'https://jservice.io/api/clues',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'category': category,
        'value': value,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class AllQuestionsCall {
  static Future<ApiCallResponse> call({
    int? category,
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'allQuestions',
      apiUrl: 'https://jservice.io/api/clues',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'category': category,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

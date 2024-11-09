// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiClientRetrofit implements ApiClientRetrofit {
  _ApiClientRetrofit(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://magento-1231949-4398885.cloudwaysapps.com/graphql';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GooglePlaceModel> getGooglePlace(endPoint) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GooglePlaceModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'place/textsearch/json?query=${endPoint}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GooglePlaceModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseModel> getUpdateToken(
    userId,
    username,
    avatar,
    token,
    accountType,
    os,
    sellerId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'userId': userId,
      'name': username,
      'avatar': avatar,
      'token': token,
      'accountType': accountType,
      'os': os,
      'sellerId': sellerId,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<BaseModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/updateTokenToDataBase',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseModel.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

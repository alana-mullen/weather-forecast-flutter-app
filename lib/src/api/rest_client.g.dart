// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://samples.openweathermap.org/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  getForecast(
      {location = 'London', appId = 'b6907d289e10d714a6e88b30761fae22'}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{'q': location, 'appid': appId};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'data/2.5/forecast',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Forecast.fromJson(_result.data);
    return Future.value(value);
  }
}

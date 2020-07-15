import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:weatherforecastflutter/src/api/api_response.dart';
import 'package:weatherforecastflutter/src/api/rest_client.dart';
import 'package:weatherforecastflutter/src/models/forecast.dart';
import 'package:weatherforecastflutter/src/constants.dart' as Constants;

class ForecastBloc {
  RestClient _repository;

  StreamController _controller;

  StreamSink<ApiResponse<Forecast>> get cartListSink =>
      _controller.sink;

  Stream<ApiResponse<Forecast>> get cartListStream =>
      _controller.stream;

  ForecastBloc() {
    _controller = StreamController<ApiResponse<Forecast>>();
    Dio dio = Dio();
    dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: Constants.BASE_URL)).interceptor);
    _repository = RestClient(dio);
    fetchForecast();
  }

  fetchForecast({bool forceRefresh = false}) async {
    cartListSink.add(ApiResponse.loading('Fetching data'));
    try {
      Options options = buildCacheOptions(
          Duration(hours: 1),
          maxStale: Duration(hours: 24),
        forceRefresh: forceRefresh
      );
      Forecast forecast = await _repository.getForecast(options: options);
      cartListSink.add(ApiResponse.completed(forecast));
    } catch (e) {
      cartListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _controller?.close();
  }
}
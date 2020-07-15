
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:weatherforecastflutter/src/models/forecast.dart';
import 'package:weatherforecastflutter/src/constants.dart' as Constants;

part 'rest_client.g.dart';

@RestApi(baseUrl: Constants.BASE_URL)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/data/2.5/forecast')
  Future<Forecast> getForecast({
    @Query('q') String location = 'London',
    @Query('appid') String appId = 'b6907d289e10d714a6e88b30761fae22',
    @DioOptions() Options options
  });
}
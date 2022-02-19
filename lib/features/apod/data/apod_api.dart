import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'today_photo/today_photo_response.dart';

part 'apod_api.g.dart';

@RestApi()
abstract class ApodApi {
  factory ApodApi(Dio dio, {String baseUrl}) = _ApodApi;

  @GET('/planetary/apod')
  Future<TodayPhotoResponse> getTodayPhoto(
      @Query('date') String? location,
      );
}
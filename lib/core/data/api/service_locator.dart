import 'package:dio/dio.dart';
import 'package:flutter_project/features/apod/data/apod_api.dart';
import 'package:flutter_project/features/apod/data/today_photo/today_photo_repository.dart';
import 'package:get_it/get_it.dart';

const defaultConnectionTimeout = Duration(seconds: 10);
const defaultReceiveTimeout = Duration(seconds: 10);
const baseUrl = 'https://api.nasa.gov';
const apiKey = 'qU2xm1N2g8mpcPvoA9aY6yQNPr8P5nM0vgPtt0Qd';

GetIt sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    await _registerNetwork();
    await _registerRepositories();
  }

  static Future<void> _registerNetwork() async {
    sl.registerSingleton(_buildDio());
    sl.registerSingleton(ApodApi(sl.get<Dio>()));
  }

  static Dio _buildDio() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: defaultConnectionTimeout.inMilliseconds,
      receiveTimeout: defaultReceiveTimeout.inMilliseconds,
      headers: {
        'x-api-key': apiKey
      }
    );

    return Dio(options);
  }

  /// Register all the repositories
  static Future<void> _registerRepositories() async {
    sl.registerSingleton(TodayPhotoRepository(sl.get()));
  }
}
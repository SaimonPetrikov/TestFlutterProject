import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter_project/features/apod/data/today_photo/today_photo.dart';
import 'package:flutter_project/features/apod/data/today_photo/today_photo_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../core/data/api/resource.dart';

class HomeBloc implements Bloc {
  final TodayPhotoRepository _todayPhotoRepository;

  final _apod = BehaviorSubject<Resource<TodayPhoto>>.seeded(Resource.loading());
  ValueStream<Resource<TodayPhoto>> get apod => _apod.stream;

  HomeBloc(this._todayPhotoRepository) {
    loadApod('');
  }

  Future<void> loadApod(String date) async {
    _apod.add(Resource.loading());

    try {
      final todayPhoto = await _todayPhotoRepository.getTodayPhoto(date);
      _apod.add(Resource.success(todayPhoto));
    } catch (exception) {
      _apod.add(Resource.error(exception));
    }
  }

  @override
  void dispose() {
    _apod.close();
  }
}
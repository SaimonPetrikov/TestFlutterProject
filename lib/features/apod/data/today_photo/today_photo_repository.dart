import 'package:intl/intl.dart';
import '../apod_api.dart';
import 'today_photo.dart';

class TodayPhotoRepository {
  final ApodApi api;

  TodayPhotoRepository(this.api);

  Future<TodayPhoto> getTodayPhoto(String date) async {
    String param = '';
    if (date != '') {
      param = date;
    } else {
      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      param = formatter.format(now);
    }
    final todayPhotoResponse = await api.getTodayPhoto(param);
    return TodayPhoto.fromResponse(todayPhotoResponse);
  }
}
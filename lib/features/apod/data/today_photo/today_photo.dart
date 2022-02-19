import 'package:flutter_project/features/apod/data/today_photo/today_photo_response.dart';

class TodayPhoto {
  final String date;
  final String? title;
  final String? explanation;
  final String? url;

  const TodayPhoto({required this.date, this.title, this.explanation, this.url});

  factory TodayPhoto.fromResponse(TodayPhotoResponse response) => TodayPhoto(
    date: response.date,
    title: response.title,
    explanation: response.explanation,
    url: response.url,
  );
}
import 'package:json_annotation/json_annotation.dart';

part 'today_photo_response.g.dart';

@JsonSerializable(nullable: false, createToJson: false)
class TodayPhotoResponse {
  String date;
  String? title;
  String? explanation;
  String? url;

  TodayPhotoResponse({required this.date, this.title, this.explanation, this.url});

  factory TodayPhotoResponse.fromJson(Map<String, dynamic> json) => _$TodayPhotoResponseFromJson(json);
}
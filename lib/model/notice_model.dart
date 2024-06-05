import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_model.freezed.dart';
part 'notice_model.g.dart';


@freezed
class NoticeModel with _$NoticeModel {
  const factory NoticeModel({
    int? nno,
    String? title,
    String? content,
    String? attachment,
    int? regdate,
  }) = _NoticeModel;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => _$NoticeModelFromJson(json);


  // factory NoticeModel.fromJson(Map<String, dynamic> json) {
  //   return _NoticeModel(
  //     nno: json['nno'] as int?,
  //     title: json['title'] as String?,
  //     content: json['content'] as String?,
  //     attachment: json['attachment'] as String?,
  //     regdate: json['regdate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['regdate']) : null,
  //   );
  // }
  //
  // Map<String, dynamic> toJson() => <String, dynamic>{
  //   'nno': nno,
  //   'title': title,
  //   'content': content,
  //   'attachment': attachment,
  //   'regdate': regdate?.millisecondsSinceEpoch,
  // };
}
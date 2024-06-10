import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'qna_model.freezed.dart';
part 'qna_model.g.dart';

@freezed
class QnaModel with _$QnaModel {
  const factory QnaModel ({
    int? pno,
    String? id,
    String? title,
    String? content,
    String? attachment,
    DateTime? regdate,
  }) = _QnaModel;

    factory QnaModel.fromJson(Map<String, dynamic> json) {
      return _QnaModel(
        pno: json['pno'] as int?,
        id: json['id'] as String?,
        title: json['title'] as String?,
        content: json['content'] as String?,
        attachment: json['attachment'] as String?,
        regdate: json['regdate'] != null ? DateTime.fromMicrosecondsSinceEpoch(json['regdate']) : null,
      );
    }

    Map<String, dynamic> toJson() => <String, dynamic>{
      'pno': pno,
      'id': id,
      'title': title,
      'content': content,
      'attachment': attachment,
      'regdate': regdate?.microsecondsSinceEpoch,
    };

}
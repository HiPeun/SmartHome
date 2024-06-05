import 'package:freezed_annotation/freezed_annotation.dart';

part 'qna_model.freezed.dart';


@freezed
class QnaModel with _$QnaModel {
  const factory QnaModel ({
    int? pno,
    String? id,
    String? title,
    String? content,
    String? attachment,
    int? regdate,
  }) = _QnaModel;

  factory QnaModel.fromJson(Map<String, dynamic> json) => _$QnaModelFromJson(json);

}
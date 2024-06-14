import 'package:freezed_annotation/freezed_annotation.dart';

part 'qna_model.freezed.dart';
part 'qna_model.g.dart';

@freezed
class QnaModel with _$QnaModel {
  const factory QnaModel({
    int? pno,
    int? mbno,
    String? name,
    String? id,
    String? title,
    String? content,
    String? attachment,
    int? regdate,
  }) = _QnaModel;

  factory QnaModel.fromJson(Map<String, dynamic> json) => _$QnaModelFromJson(json);
}

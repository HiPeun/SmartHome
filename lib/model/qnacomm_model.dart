import 'package:freezed_annotation/freezed_annotation.dart';

part 'qnacomm_model.freezed.dart';
part 'qnacomm_model.g.dart';

@freezed
class QnaCommModel with _$QnaCommModel {
  const factory QnaCommModel ({
    int? pcno,
    int? pno,
    int? mbno,
    String? content,
    int? regdate,
  }) = _QnaCommModel;

  factory QnaCommModel.fromJson(Map<String, dynamic> json) => _$QnaCommModelFromJson(json);

}
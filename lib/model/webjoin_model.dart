
import 'package:freezed_annotation/freezed_annotation.dart';


part 'webjoin_model.g.dart';
part 'webjoin_model.freezed.dart';


@freezed
class WebJoinModel with _$WebJoinModel {
  const factory WebJoinModel({
    String? id,
    String? pw,
    String? pw2,
    String? email,
    String? name,
    String? title,
    String? content,

  }) = _WebJoinModel;

  factory WebJoinModel.fromJson(Map<String, dynamic> json) => _$WebJoinModelFromJson(json);
}

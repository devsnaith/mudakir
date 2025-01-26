import 'package:json_annotation/json_annotation.dart';

part "adhkar_model.g.dart";

@JsonSerializable()
class AdhkarModel {
  
  final int section_id;
  final int count;
  final String reference;
  final String content;

  AdhkarModel({
    required this.section_id,
    required this.count,
    required this.reference,
    required this.content,
  });

  factory AdhkarModel.fromJson(Map<String, dynamic> json) => _$AdhkarModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdhkarModelToJson(this);

}
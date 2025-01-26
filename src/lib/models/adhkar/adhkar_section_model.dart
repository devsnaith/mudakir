import 'package:json_annotation/json_annotation.dart';

part 'adhkar_section_model.g.dart';

@JsonSerializable()
class AdhkarSectionModel {

  final int id;
  final String name;

  AdhkarSectionModel({
    required this.id,
    required this.name,
  });

  factory AdhkarSectionModel.fromJson(Map<String, dynamic> json) => _$AdhkarSectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$AdhkarSectionModelToJson(this);

}
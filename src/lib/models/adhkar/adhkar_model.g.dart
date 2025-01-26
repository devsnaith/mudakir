// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adhkar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdhkarModel _$AdhkarModelFromJson(Map<String, dynamic> json) => AdhkarModel(
      section_id: (json['section_id'] as num).toInt(),
      count: (json['count'] as num).toInt(),
      reference: json['reference'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$AdhkarModelToJson(AdhkarModel instance) =>
    <String, dynamic>{
      'section_id': instance.section_id,
      'count': instance.count,
      'reference': instance.reference,
      'content': instance.content,
    };

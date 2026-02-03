// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Attachment _$AttachmentFromJson(Map<String, dynamic> json) => _Attachment(
  originalname: json['originalname'] as String?,
  filename: json['filename'] as String?,
  location: json['location'] as String,
);

Map<String, dynamic> _$AttachmentToJson(_Attachment instance) =>
    <String, dynamic>{
      'originalname': instance.originalname,
      'filename': instance.filename,
      'location': instance.location,
    };

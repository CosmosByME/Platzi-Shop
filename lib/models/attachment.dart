import 'package:freezed_annotation/freezed_annotation.dart';
part 'attachment.freezed.dart';
part 'attachment.g.dart';

@freezed
abstract class Attachment with _$Attachment {
  const Attachment._();
  const factory Attachment({
    String? originalname,
    String? filename,
    required String location,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, Object?> json) =>
      _$AttachmentFromJson(json);
}

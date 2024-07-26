import 'package:apos/lib_exp.dart';

sealed class AttachmentsEvent {}

class AttachmentsEventPickImage extends AttachmentsEvent {
  final AttachmentFile file;
  AttachmentsEventPickImage({required this.file});
}

class AttachmentEventRemoveImage extends AttachmentsEvent {
  final int index;
  AttachmentEventRemoveImage({required this.index});
}

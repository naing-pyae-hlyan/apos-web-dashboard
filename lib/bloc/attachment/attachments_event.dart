sealed class AttachmentsEvent {}

class AttachmentsEventSetImages extends AttachmentsEvent {
  final List<String> base64Images;
  AttachmentsEventSetImages({required this.base64Images});
}

class AttachmentsEventPickImage extends AttachmentsEvent {
  final String base64Image;
  AttachmentsEventPickImage({required this.base64Image});
}

class AttachmentEventRemoveImage extends AttachmentsEvent {
  final int index;
  AttachmentEventRemoveImage({required this.index});
}

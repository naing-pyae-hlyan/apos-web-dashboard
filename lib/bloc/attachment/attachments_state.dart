sealed class AttachmentsState {
  final List<String> base64Images;
  AttachmentsState({required this.base64Images});
}

class AttachmentsStateSetImages extends AttachmentsState {
  AttachmentsStateSetImages({required super.base64Images});
}

class AttachmentStateInitial extends AttachmentsState {
  AttachmentStateInitial({required super.base64Images});
}

class AttachmentStatePickedImage extends AttachmentsState {
  AttachmentStatePickedImage({required super.base64Images});
}

class AttachmentStateRemovedImage extends AttachmentsState {
  AttachmentStateRemovedImage({required super.base64Images});
}

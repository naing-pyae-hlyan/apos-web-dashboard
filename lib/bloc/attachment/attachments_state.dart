import 'package:apos/lib_exp.dart';

sealed class AttachmentsState {
  final List<AttachmentFile> files;
  AttachmentsState({required this.files});
}

class AttachmentStateInitial extends AttachmentsState {
  AttachmentStateInitial({required super.files});
}

class AttachmentStatePickedImage extends AttachmentsState {
  AttachmentStatePickedImage({required super.files});
}

class AttachmentStateRemovedImage extends AttachmentsState {
  AttachmentStateRemovedImage({required super.files});
}

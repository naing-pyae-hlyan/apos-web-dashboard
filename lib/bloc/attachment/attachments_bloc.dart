import 'package:apos/lib_exp.dart';

class AttachmentsBloc extends Bloc<AttachmentsEvent, AttachmentsState> {
  AttachmentsBloc() : super(AttachmentStateInitial(base64Images: [])) {
    on<AttachmentsEventSetImages>(_onSetImages);
    on<AttachmentsEventPickImage>(_onPickImage);
    on<AttachmentEventRemoveImage>(_onRemoveImage);
  }

  Future<void> _onSetImages(
    AttachmentsEventSetImages event,
    Emitter<AttachmentsState> emit,
  ) async {
    state.base64Images.clear();
    for (String image in event.base64Images) {
      state.base64Images.add(image);
    }
    emit(AttachmentsStateSetImages(base64Images: state.base64Images));
  }

  Future<void> _onPickImage(
    AttachmentsEventPickImage event,
    Emitter<AttachmentsState> emit,
  ) async {
    state.base64Images.add(event.base64Image);
    emit(AttachmentStatePickedImage(base64Images: state.base64Images));
  }

  Future<void> _onRemoveImage(
    AttachmentEventRemoveImage event,
    Emitter<AttachmentsState> emit,
  ) async {
    if (state.base64Images.length < event.index) return;
    state.base64Images.removeAt(event.index);
    emit(AttachmentStateRemovedImage(base64Images: state.base64Images));
  }
}

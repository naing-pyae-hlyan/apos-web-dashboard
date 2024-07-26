import 'package:apos/lib_exp.dart';

class AttachmentsBloc extends Bloc<AttachmentsEvent, AttachmentsState> {
  AttachmentsBloc() : super(AttachmentStateInitial(files: [])) {
    on<AttachmentsEventPickImage>(_onPickImage);
    on<AttachmentEventRemoveImage>(_onRemoveImage);
  }

  Future<void> _onPickImage(
    AttachmentsEventPickImage event,
    Emitter<AttachmentsState> emit,
  ) async {
    state.files.add(event.file);
    emit(AttachmentStatePickedImage(files: state.files));
  }

  Future<void> _onRemoveImage(
    AttachmentEventRemoveImage event,
    Emitter<AttachmentsState> emit,
  ) async {
    if (state.files.length < event.index) return;
    state.files.removeAt(event.index);
    emit(AttachmentStateRemovedImage(files: state.files));
  }
}

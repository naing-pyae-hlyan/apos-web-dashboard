import 'package:apos/lib_exp.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersStateInitial()) {
    on<UsersEventRead>(_onRead);
    on<UsersEventCreate>(_onCreate);
    on<UsersEventUpdate>(_onUpdate);
    on<UsersEventDelete>(_onDelete);
    on<UsersEventSearch>(_onSearch);
  }

  Future<void> _onRead(UsersEventRead event, Emitter<UsersState> emit) async {
    LoadingDialog.show();
    await FFirestoreUtils.userCollection.orderBy("name").get().then(
      (QuerySnapshot<UserModel> snapshot) {
        LoadingDialog.hide();
        if (event.readSuccess != null) {
          event.readSuccess!();
        }
      },
    ).catchError((_) {
      LoadingDialog.hide();
    });
  }

  Future<void> _onCreate(
    UsersEventCreate event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersStateLoading());
    if (event.user.username.isEmpty) {
      emit(_dialogStateFail(message: "Enter Username", code: 1));
      return;
    }
    if (event.user.email.isEmpty) {
      emit(_dialogStateFail(message: "Enter Email", code: 2));
      return;
    }
    if (event.user.password.isEmpty) {
      emit(_dialogStateFail(message: "Enter Password", code: 3));
      return;
    }

    await FFirestoreUtils.userCollection
        .add(event.user)
        .then((_) => emit(UsersStateCreateSuccess()))
        .catchError(
          (error) => emit(_dialogStateFail(message: error.toString(), code: 3)),
        );
  }

  Future<void> _onUpdate(
    UsersEventUpdate event,
    Emitter<UsersState> emit,
  ) async {}

  Future<void> _onDelete(
    UsersEventDelete event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersStateLoading());
    await FFirestoreUtils.userCollection
        .doc(event.userId)
        .delete()
        .then((_) => emit(UsersStateDeleteSuccess()))
        .catchError(
          (error) => _dialogStateFail(message: error.toString()),
        );
  }

  Future<void> _onSearch(
    UsersEventSearch event,
    Emitter<UsersState> emit,
  ) async {
    emit(UsersStateSearch(query: event.query));
  }

  UsersStateFail _dialogStateFail({required String message, int code = 1}) =>
      UsersStateFail(
        error: ErrorModel(message: message, code: code),
      );
}

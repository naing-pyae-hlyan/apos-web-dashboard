import 'package:apos/lib_exp.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateInitial(selectedPage: SelectedHome.dashboard)) {
    on<HomeEventDrawerChanged>(_onChanged);
  }

  SelectedHome selectedHomeItems = SelectedHome.dashboard;

  Future<void> _onChanged(
    HomeEventDrawerChanged event,
    Emitter<HomeState> emit,
  ) async {
    selectedHomeItems = event.selectedPage;
    emit(HomeStateChanged(selectedPage: event.selectedPage));
  }
}

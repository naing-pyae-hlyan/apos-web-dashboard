import 'package:apos/enum/selected_home.dart';

sealed class HomeState {
  SelectedHome selectedPage;
  HomeState({required this.selectedPage});
}

class HomeStateInitial extends HomeState {
  HomeStateInitial({required super.selectedPage});
}

class HomeStateChanged extends HomeState {
  HomeStateChanged({required super.selectedPage});
}

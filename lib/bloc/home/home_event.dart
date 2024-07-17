import 'package:apos/enum/_exp.dart';

sealed class HomeEvent {}

class HomeEventDrawerChanged extends HomeEvent {
  final SelectedHome selectedPage;
  HomeEventDrawerChanged({required this.selectedPage});
}

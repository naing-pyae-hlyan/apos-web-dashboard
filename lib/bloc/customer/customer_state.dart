import 'package:apos/lib_exp.dart';

sealed class CustomerState {}

class CustomerStateInitial extends CustomerState {}

class CustomerStateLoading extends CustomerState {}

class CustomerStateUpdateStatusSuccess extends CustomerState {}

class CustomerStateSearch extends CustomerState {
  final String query;
  CustomerStateSearch(this.query);
}

class CustomerStateFailed extends CustomerState {
  final ErrorModel error;
  CustomerStateFailed({required this.error});
}

part of 'employee_list_bloc.dart';

@immutable
abstract class EmployeeListState {}

abstract class EmployeeListActionState extends EmployeeListState {}

class EmployeeListInitial extends EmployeeListState {}

class EmployeeListLoaded extends EmployeeListState {
  final List<Employee> employees;

  EmployeeListLoaded(this.employees);
}

class EmployeeListError extends EmployeeListState {
  final String errorMessage;

  EmployeeListError(this.errorMessage);
}

class NavigateToAddEmployeeState extends EmployeeListActionState {}


class NavigateToEditEmployeeState extends EmployeeListActionState {
  final Employee employee;

  NavigateToEditEmployeeState(this.employee);
}
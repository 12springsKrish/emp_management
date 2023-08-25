part of 'employee_list_bloc.dart';

@immutable
abstract class EmployeeListEvent {}

class NavigateToAddEmployeeButtonClickEvent extends EmployeeListEvent{

}

class FetchEmployeeListEvent extends EmployeeListEvent {}

class DeleteEmployeeEvent extends EmployeeListEvent {
  final Employee employee;

  DeleteEmployeeEvent(this.employee);
}

class NavigateToEditEmployeeEvent extends EmployeeListEvent {
  final Employee employee;

  NavigateToEditEmployeeEvent(this.employee);
}


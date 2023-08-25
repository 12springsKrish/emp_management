import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emp_management_app/models/emp_details.dart';
import 'package:emp_management_app/utils/database_helper.dart';
import 'package:meta/meta.dart';

part 'employee_list_event.dart';

part 'employee_list_state.dart';

class EmployeeListBloc extends Bloc<EmployeeListEvent, EmployeeListState> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  EmployeeListBloc() : super(EmployeeListInitial()) {
    on<NavigateToAddEmployeeButtonClickEvent>(navigateToAddEmployee);
    on<FetchEmployeeListEvent>(_fetchEmployeeList);
    on<DeleteEmployeeEvent>(_deleteEmployee);
    on<NavigateToEditEmployeeEvent>(navigateToEditEmployee);
  }

  Future<void> navigateToAddEmployee(
      NavigateToAddEmployeeButtonClickEvent event,
      Emitter<EmployeeListState> emit) async {
    emit(NavigateToAddEmployeeState());
  }

  Future<void> _fetchEmployeeList(
      FetchEmployeeListEvent event, Emitter<EmployeeListState> emit) async {
    try {
      final List<Employee> employees = await databaseHelper.getEmployees();

      emit(EmployeeListLoaded(employees));
    } catch (e) {
      emit(EmployeeListError('Error fetching employee list.'));
    }
  }

  Future<void> _deleteEmployee(
      DeleteEmployeeEvent event, Emitter<EmployeeListState> emit) async {
    try {
      await databaseHelper.deleteEmployee(event.employee.id);
      final List<Employee> updatedEmployees =
          await databaseHelper.getEmployees();
      emit(EmployeeListLoaded(updatedEmployees));
    } catch (e) {
      emit(EmployeeListError('Error deleting employee.'));
    }
  }

  Future<void> navigateToEditEmployee(NavigateToEditEmployeeEvent event,
      Emitter<EmployeeListState> emit) async {
    emit(NavigateToEditEmployeeState(event.employee));
  }
}

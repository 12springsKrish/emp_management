import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:emp_management_app/models/emp_details.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_event.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_state.dart';
import 'package:emp_management_app/utils/database_helper.dart';

class EmployeeDetailBloc
    extends Bloc<EmployeeDetailEvent, EmployeeDetailState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  DateTime _selectedDate = DateTime.now();
  bool _isDateSelected = false;

  DateTime calculateNextWeekday(int targetWeekday, {DateTime? baseDate}) {
    final DateTime now = baseDate ?? DateTime.now();
    int daysUntilNextWeekday = targetWeekday - now.weekday;
    if (daysUntilNextWeekday <= 0) {
      daysUntilNextWeekday += 7;
    }
    return now.add(Duration(days: daysUntilNextWeekday));
  }

  EmployeeDetailBloc() : super(EmployeeDetailInitial()) {
    on<AddEmployeeDetailEvent>(_addEmployeeEvent);
    on<NameSelectedEvent>(_nameSelectedEvent);
    on<RoleSelectedEvent>(_roleSelectedEvent);
    on<DateSelectedEvent>(_dateSelectedEvent);
    on<TodayButtonPressedEvent>(_todayButtonPressed);
    on<NextMondayButtonPressedEvent>(_nextMondayButtonPressed);
    on<NextTuesdayButtonPressedEvent>(_nextTuesdayButtonPressed);
    on<AfterOneWeekButtonPressedEvent>(_afterOneWeekButtonPressed);
    on<NoDateButtonPressedEvent>(_noDateButtonPressed);
    on<UpdateEmployeeDetailEvent>(_updateEmployeeEvent);
    on<EndDateSelectedEvent>(_endDateSelectedEvent);
  }

  Future<void> _addEmployeeEvent(AddEmployeeDetailEvent event,
      Emitter<EmployeeDetailState> emit,) async {
    try {
      await _databaseHelper.openDatabase();
      await _databaseHelper.insertEmployee(
          event.name, event.role, event.startDate, event.endDate);
      await _databaseHelper.printEmployees();
      emit(EmployeeDetailAdded());
    } catch (e) {
      emit(EmployeeDetailError(
          "An error occurred while adding employee details."));
    }
  }

  void _nameSelectedEvent(NameSelectedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    emit(EmployeeDetailNameSelected(event.selectedName));
  }

  void _roleSelectedEvent(RoleSelectedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    emit(EmployeeDetailRoleSelected(event.selectedRole));
  }

  void _dateSelectedEvent(DateSelectedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    emit(EmployeeDetailDateSelected(event.selectedDate));
  }

  void _endDateSelectedEvent(EndDateSelectedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    emit(EmployeeDetailEndDateSelected(event.endselectedDate));
  }

  void _todayButtonPressed(TodayButtonPressedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    _selectedDate = DateTime.now();
    emit(EmployeeDetailDateSelected(_selectedDate));
  }

  void _nextMondayButtonPressed(NextMondayButtonPressedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    _selectedDate = calculateNextWeekday(DateTime.monday);
    print(_selectedDate);
    emit(EmployeeDetailDateSelected(_selectedDate));
  }

  void _nextTuesdayButtonPressed(NextTuesdayButtonPressedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    _selectedDate = calculateNextWeekday(DateTime.tuesday);
    print(_selectedDate);
    emit(EmployeeDetailDateSelected(_selectedDate));
  }

  void _afterOneWeekButtonPressed(AfterOneWeekButtonPressedEvent event,
      Emitter<EmployeeDetailState> emit,) {
    _selectedDate = DateTime.now().add(const Duration(days: 7));
    print(_selectedDate);
    emit(EmployeeDetailDateSelected(_selectedDate));
  }

  void _noDateButtonPressed(NoDateButtonPressedEvent event,
      Emitter<EmployeeDetailState> emit,) {
  _isDateSelected = false;
    emit(EmployeeDetailDateNotSelected());
   /* emit(EmployeeDetailDateSelected(_selectedDate));*/
  }

  Future<void> _updateEmployeeEvent(UpdateEmployeeDetailEvent event,
      Emitter<EmployeeDetailState> emit,) async {
    try {
      await _databaseHelper.updateEmployee(event.updatedEmployee);
      emit(EmployeeDetailUpdated());
    } catch (e) {
      emit(EmployeeDetailError('Error updating employee details.'));
    }
  }

}

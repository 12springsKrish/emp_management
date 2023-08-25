import '../../models/emp_details.dart';

abstract class EmployeeDetailEvent {}

class AddEmployeeDetailEvent extends EmployeeDetailEvent {
  final String name;
  final String role;
  final String startDate;
  final String endDate;


  AddEmployeeDetailEvent({
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate
  });
}

class NameSelectedEvent extends EmployeeDetailEvent {
  final String selectedName;

  NameSelectedEvent(this.selectedName);
}

class RoleSelectedEvent extends EmployeeDetailEvent {
  final String selectedRole;

  RoleSelectedEvent(this.selectedRole);
}

class DateSelectedEvent extends EmployeeDetailEvent {
  final DateTime selectedDate;

  DateSelectedEvent(this.selectedDate);
}

class EndDateSelectedEvent extends EmployeeDetailEvent {
  final DateTime endselectedDate;

  EndDateSelectedEvent(this.endselectedDate);
}

class UpdateEmployeeDetailEvent extends EmployeeDetailEvent {
  final Employee updatedEmployee;

  UpdateEmployeeDetailEvent(this.updatedEmployee);
}



class TodayButtonPressedEvent extends EmployeeDetailEvent {}

class NextMondayButtonPressedEvent extends EmployeeDetailEvent {}

class NextTuesdayButtonPressedEvent extends EmployeeDetailEvent {}

class AfterOneWeekButtonPressedEvent extends EmployeeDetailEvent {}

class NoDateButtonPressedEvent extends EmployeeDetailEvent {}






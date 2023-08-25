abstract class EmployeeDetailState {}

class EmployeeDetailInitial extends EmployeeDetailState {}

class EmployeeDetailNameSelected extends EmployeeDetailState {
  final String selectedName;

  EmployeeDetailNameSelected(this.selectedName);
}

class EmployeeDetailRoleSelected extends EmployeeDetailState {
  final String selectedRole;

  EmployeeDetailRoleSelected(this.selectedRole);
}

class EmployeeDetailDateSelected extends EmployeeDetailState {
  final DateTime selectedDate;

  EmployeeDetailDateSelected(this.selectedDate);
}

class EmployeeDetailEndDateSelected extends EmployeeDetailState {
  final DateTime endselectedDate;

  EmployeeDetailEndDateSelected(this.endselectedDate);
}



class EmployeeDetailDateNotSelected extends EmployeeDetailState {}

class EmployeeDetailAdded extends EmployeeDetailState {}

class EmployeeDetailError extends EmployeeDetailState {
  final String errorMessage;

  EmployeeDetailError(this.errorMessage);

}


class EmployeeDetailUpdated extends EmployeeDetailState {

}


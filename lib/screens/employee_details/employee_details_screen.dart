import 'package:emp_management_app/models/emp_details.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_bloc.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_event.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_state.dart';
import 'package:emp_management_app/utils/util_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final Employee? employee;

  EmployeeDetailsScreen({Key? key, this.employee}) : super(key: key);

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();

  String? selectedRole;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String? formattedDate;
  bool isExisting = false;
  int? id;

  void _openModalBottomSheet(BuildContext context, EmployeeDetailBloc bloc) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      builder: (BuildContext context) {
        return SizedBox(
          height: 275,
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'Product Designer',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedRole = "Product Designer";
                  bloc.add(RoleSelectedEvent('Product Designer'));
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Flutter Developer',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedRole = "Flutter Developer";
                  bloc.add(RoleSelectedEvent('Flutter Developer'));
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'QA Tester',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedRole = "QA Tester";
                  bloc.add(RoleSelectedEvent('QA Tester'));
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'Product Owner',
                  textAlign: TextAlign.center,
                ),
                onTap: () {
                  selectedRole = "Product Owner";
                  bloc.add(RoleSelectedEvent('Product Owner'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final employee = args['employee'];
    final isEditing = args['isEditing'];
    if (employee != null && isEditing == true) {
      _nameController.text = employee.name;
      selectedRole = employee.role;
      id = employee.id;
      selectedDate = DateTime.parse(employee.startDate);
      DateFormat dateFormat = DateFormat("d MMM yyyy");
      formattedDate = dateFormat.format(selectedDate);
      isExisting = true;
    } else if (employee == null && isEditing == false) {
      isExisting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final EmployeeDetailBloc employeeDetailBloc =
        context.read<EmployeeDetailBloc>();
    return BlocConsumer<EmployeeDetailBloc, EmployeeDetailState>(
      listener: (context, state) {
        if (state is EmployeeDetailAdded) {
          const snackBar = SnackBar(
            content: Text("Employee Added"),
            duration: Duration(milliseconds: 10),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushNamed(context, routeEmployeeList);
        } else if (state is EmployeeDetailError) {
          // Handle error, e.g., show an error message
        }
        if (state is EmployeeDetailDateSelected) {
          print("Before State Change - selectedDate: $selectedDate");
          selectedDate = state.selectedDate;
          print("After State Change - selectedDate: $selectedDate");
          var snackBar = SnackBar(
            content: Text("${selectedDate}"),
            duration: Duration(milliseconds: 1000),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // Update the selected date
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Add Employee Details"),
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      color: Colors.blue,
                    ),
                    hintText: 'Employee Name',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    _openModalBottomSheet(context, employeeDetailBloc);
                  },
                  child: TextField(
                    /*readOnly: true,*/
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.blue,
                      ),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                        weight: 10,
                        color: Colors.blue,
                      ),
                      hintText: selectedRole ?? 'Select Role',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final EmployeeDetailBloc employeeDetailBloc =
                                      BlocProvider.of<EmployeeDetailBloc>(
                                          context);
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      employeeDetailBloc.add(
                                                          TodayButtonPressedEvent());
                                                    },
                                                    child: const Text("Today"),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      employeeDetailBloc.add(
                                                          NextMondayButtonPressedEvent());
                                                    },
                                                    child: const Text(
                                                        'Next Monday'),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      employeeDetailBloc.add(
                                                          NextTuesdayButtonPressedEvent());
                                                    },
                                                    child: const Text(
                                                        "Next Tuesday"),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      employeeDetailBloc.add(
                                                          AfterOneWeekButtonPressedEvent());
                                                    },
                                                    child: const Text(
                                                        'After 1 Week'),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        const Divider(),
                                        BlocBuilder<EmployeeDetailBloc,
                                            EmployeeDetailState>(
                                          builder: (context, state) {
                                            print("BlocBuilder Rebuilt");
                                            if (state
                                                is EmployeeDetailDateSelected) {
                                              selectedDate = state.selectedDate;
                                            }
                                            return Container(
                                                height: 350,
                                                child: TableCalendar(
                                                  availableCalendarFormats: {
                                                    CalendarFormat.month:
                                                        'Month'
                                                  },
                                                  selectedDayPredicate: (day) {
                                                    return isSameDay(
                                                        day, selectedDate);
                                                  },
                                                  firstDay: DateTime.utc(
                                                      2010, 10, 16),
                                                  lastDay:
                                                      DateTime.utc(2030, 3, 14),
                                                  onDaySelected: (selectedDay,
                                                      focusedDay) {
                                                    employeeDetailBloc.add(
                                                        DateSelectedEvent(
                                                            selectedDay));
                                                  },
                                                  focusedDay: selectedDate,
                                                  calendarStyle:
                                                      const CalendarStyle(
                                                    // Customize the style of highlighted dates
                                                    selectedDecoration:
                                                        BoxDecoration(
                                                      color: Colors.blue,
                                                      // Customize the highlight color
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ));
                                          },
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            BlocConsumer<EmployeeDetailBloc,
                                                EmployeeDetailState>(
                                              listener: (context, state) {
                                                // TODO: implement listener
                                                if (state
                                                    is EmployeeDetailDateSelected) {
                                                  selectedDate =
                                                      state.selectedDate;
                                                }
                                              },
                                              builder: (context, state) {
                                                return Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(selectedDate
                                                        .toString()
                                                        .substring(0, 10))
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel")),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Save"))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              weight: 10,
                              color: Colors.blue,
                            ),
                          ),
                          hintText: selectedDate != null
                              ? selectedDate.toString().substring(0, 10)
                              : 'Today',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.blue,
                    ),
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final EmployeeDetailBloc employeeDetailBloc =
                                      BlocProvider.of<EmployeeDetailBloc>(
                                          context);
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      employeeDetailBloc.add(
                                                          TodayButtonPressedEvent());
                                                    },
                                                    child:
                                                        const Text("No Date"),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      employeeDetailBloc.add(
                                                          TodayButtonPressedEvent());
                                                    },
                                                    child: const Text('Today'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        const Divider(),
                                        BlocBuilder<EmployeeDetailBloc,
                                            EmployeeDetailState>(
                                          builder: (context, state) {
                                            print("BlocBuilder Rebuilt");

                                            return Container(
                                                height: 350,
                                                child: TableCalendar(
                                                  availableCalendarFormats: {
                                                    CalendarFormat.month:
                                                        'Month'
                                                  },
                                                  selectedDayPredicate: (day) {
                                                    return selectedEndDate != null && isSameDay(day, selectedEndDate);
                                                  },
                                                  firstDay: DateTime.utc(
                                                      2010, 10, 16),
                                                  lastDay:
                                                      DateTime.utc(2030, 3, 14),
                                                  onDaySelected: (selectedDay,
                                                      focusedDay) {
                                                    employeeDetailBloc.add(
                                                        DateSelectedEvent(
                                                            selectedDay));
                                                  },
                                                  focusedDay: selectedEndDate,
                                                  calendarStyle:
                                                      const CalendarStyle(
                                                    // Customize the style of highlighted dates
                                                    selectedDecoration:
                                                        BoxDecoration(
                                                      color: Colors.blue,
                                                      // Customize the highlight color
                                                      shape: BoxShape.circle,
                                                    ),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ));
                                          },
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            BlocConsumer<EmployeeDetailBloc,
                                                EmployeeDetailState>(
                                              listener: (context, state) {
                                                // TODO: implement listener
                                                if(state is EmployeeDetailEndDateSelected){
                                                  selectedEndDate = state.endselectedDate;
                                                }
                                              },
                                              builder: (context, state) {
                                                return Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      color: Colors.blue,
                                                    ),
                                                    Text(selectedEndDate
                                                        .toString()
                                                        .substring(0, 10))
                                                  ],
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: const Text("Cancel")),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Save"))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                              weight: 10,
                              color: Colors.blue,
                            ),
                          ),
                          hintText: 'No Date',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _nameController.clear();
                          Navigator.pushNamed(context, routeEmployeeList);
                        }, child: const Text("Cancel")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (isExisting) {
                          // Update the existing employee
                          final updatedEmployee = Employee(
                            id: id!,
                            name: _nameController.text,
                            role: selectedRole.toString(),
                            startDate: selectedDate.toString(),
                            endDate: selectedEndDate.toString()
                          );
                          employeeDetailBloc
                              .add(UpdateEmployeeDetailEvent(updatedEmployee));
                          const snackBar = SnackBar(
                            content: Text("Employee Updated"),
                            duration: Duration(milliseconds: 20),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushNamed(context, routeEmployeeList);
                        } else {
                          // Add a new employee
                          employeeDetailBloc.add(AddEmployeeDetailEvent(
                            name: _nameController.text,
                            role: selectedRole.toString(),
                            startDate: selectedDate.toString(),
                            endDate: selectedEndDate.toString()
                          ));
                        }
                      },
                      child: const Text("Save"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

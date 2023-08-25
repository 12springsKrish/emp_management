/*
import 'package:emp_management_app/screens/employee_details/employee_detail_bloc.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_event.dart';
import 'package:emp_management_app/screens/employee_details/employee_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

customDatePicker(context) {
  DateTime selectedDate = DateTime.now();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      final EmployeeDetailBloc employeeDetailBloc =
      BlocProvider.of<EmployeeDetailBloc>(context);
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          employeeDetailBloc.add(TodayButtonPressedEvent());
                          */
/* setState(() {
                          _selectedDate = DateTime.now();
                        });*//*

                        },
                        child: Text('Today'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          employeeDetailBloc.add(
                              NextMondayButtonPressedEvent());

                          */
/*_calculateNextWeekday(DateTime.monday);*//*

                        },
                        child: Text('Next Monday'),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          employeeDetailBloc.add(
                              NextTuesdayButtonPressedEvent());

                          */
/* _calculateNextWeekday(DateTime.tuesday);*//*

                        },
                        child: Text('Next Tuesday'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        employeeDetailBloc.add(
                            AfterOneWeekButtonPressedEvent());
                        */
/*  setState(() {
                        _selectedDate = DateTime.now().add(Duration(days: 7));
                      });*//*

                      },
                      child: Text('After One Week'),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Divider(),
            BlocBuilder<EmployeeDetailBloc, EmployeeDetailState>(
              builder: (context, state) {
                if (state is EmployeeDetailDateSelected) {
                  selectedDate = state.selectedDate;
                  print(selectedDate);// Update the selected date
                }
                return Container(
                    height: 350,
                    child: TableCalendar(
                      availableCalendarFormats: {CalendarFormat.month: 'Month'},
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: selectedDate,
                    ));
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.blue,
                    ),
                    Text(selectedDate.toString().substring(0,10))
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(onPressed: () {}, child: Text("Cancel")),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(onPressed: () {}, child: Text("Save"))
              ],
            )
          ],
        ),
      );
    },
  );
}
*/

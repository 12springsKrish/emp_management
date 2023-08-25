import 'package:emp_management_app/screens/employee_details/employee_detail_bloc.dart';
import 'package:emp_management_app/screens/employee_details/employee_details_screen.dart';
import 'package:emp_management_app/screens/employee_list/employee_list_bloc.dart';
import 'package:emp_management_app/screens/employee_list/employee_list_screen.dart';
import 'package:emp_management_app/utils/util_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().openDatabase();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeListBloc>(
          create: (context) => EmployeeListBloc(),
        ),
        BlocProvider<EmployeeDetailBloc>(
          create: (context) => EmployeeDetailBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Employee App',
        home: EmployeeListScreen(),
        routes: {
          routeAddEmployee : (BuildContext context) => EmployeeDetailsScreen(),
          routeEmployeeList : (BuildContext context) => EmployeeListScreen()
        },
      ),
    );
  }
}

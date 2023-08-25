import 'package:emp_management_app/screens/employee_list/employee_list_bloc.dart';
import 'package:emp_management_app/utils/util_fonts.dart';
import 'package:emp_management_app/utils/util_images.dart';
import 'package:emp_management_app/utils/util_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<EmployeeListBloc>().add(FetchEmployeeListEvent());
  }

  @override
  Widget build(BuildContext context) {
    final EmployeeListBloc employeeListBloc = EmployeeListBloc();
    employeeListBloc.add(FetchEmployeeListEvent());
    return BlocConsumer<EmployeeListBloc, EmployeeListState>(
      bloc: employeeListBloc,
      listener: (context, state) {
        if (state is NavigateToAddEmployeeState) {
          Navigator.pushNamed(context, routeAddEmployee, arguments: {
            'employee': null,
            'isEditing': false,
          });
        } else if (state is NavigateToEditEmployeeState) {
          Navigator.pushNamed(context, routeAddEmployee, arguments: {
            'employee': state.employee,
            'isEditing': true,
          });
        }
      },
      builder: (context, state) {
        if (state is EmployeeListLoaded) {
          final employees = state.employees;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Employee List"),
            ),
            floatingActionButton: RawMaterialButton(
              onPressed: () {
                employeeListBloc.add(NavigateToAddEmployeeButtonClickEvent());
              },
              child: Image.asset(addEmployee),
            ),
            body: employees.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(noEmployee),
                        Text(
                          "No employee records found",
                          style: CustomTextStyles.bold(fontSize: 18.0),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                              "Current employees",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              )
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListView.builder(
                        shrinkWrap: true,
                        itemCount: employees.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final employee = employees[index];
                          return employee != null
                              ? Dismissible(
                            key: Key(employee.id.toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              employeeListBloc
                                  .add(DeleteEmployeeEvent(employee));
                            },
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: Colors.red,
                              child: const Padding(
                                padding: EdgeInsets.only(right: 16.0),
                                child:
                                Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                            child: InkWell(
                              onTap: (){
                                employeeListBloc.add(
                                    NavigateToEditEmployeeEvent(employee));
                              },
                              child: Container(
                                color: Colors.white,
                                child: Column(
                                  children: [

                                    ListTile(
                                      title: Text(employee.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(employee.role,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              )),
                                          Text("From ${employee.startDate.substring(0,10)} to ${employee.endDate.substring(0,10)}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ))
                                        ],
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                ),
                              ),
                            ),
                          )
                              : const SizedBox.shrink();
                        },
                      ),]
                    ),
                  ),
          );
        } else {
          return Scaffold(

            appBar: AppBar(
              title: const Text("Employee List"),
            ),
            floatingActionButton: RawMaterialButton(
              onPressed: () {
                employeeListBloc.add(NavigateToAddEmployeeButtonClickEvent());
              },
              child: Image.asset(addEmployee),
            ),
            /*body: const Center(
              child: CircularProgressIndicator(), // Display loading indicator
            ),*/
          );
        }
      },
    );
  }
}

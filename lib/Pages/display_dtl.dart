import 'package:employee_dtl_app/Pages/edit_dtl.dart';
import 'package:employee_dtl_app/Pages/insert_employee_dtl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayDetails extends StatefulWidget {
  const DisplayDetails({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DisplayDetailsState createState() => _DisplayDetailsState();
}

class _DisplayDetailsState extends State {
  late List<Map<String, dynamic>> mergedData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('employees').get();
    final List<Map<String, dynamic>> employeeList = [];
    for (var doc in querySnapshot.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['documentId'] = doc.id;
      double grossSalary = double.parse(data['salary']);
      double deduction = grossSalary * 0.02;
      double netSalary = grossSalary - deduction;
      data['netSalary'] = netSalary;
      employeeList.add(data);
    }
    setState(() {
      mergedData = employeeList;
    });
  }

  void deleteEmployee(String documentId) async {
    await FirebaseFirestore.instance
        .collection('employees')
        .doc(documentId)
        .delete();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        backgroundColor: Color.fromARGB(255, 36, 160, 41),
      ),
      body: ListView.builder(
        itemCount: mergedData.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> employee = mergedData[index];
          return ListTile(
            title: Text(employee['name']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Position: ${employee['position']}'),
                Text('Department: ${employee['department']}'),
                Text('Gross Salary: ${employee['salary']}'),
                Text('Net Salary: ${employee['netSalary']}'),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => EditEmployeeDetails(
                              documentId: employee['documentId'],
                              name: employee['name'],
                              position: employee['position'],
                              department: employee['department'],
                              contactNumber: employee['contactNumber'],
                              salary: employee['salary'],
                            ),
                          ),
                        )
                            .then((_) {
                          fetchData();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 36, 160, 41),
                      ),
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        deleteEmployee(employee['documentId']);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 175, 23, 12),
                      ),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 200,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmployeeDtl(
                  updateCallback: fetchData,
                  refreshData: () {},
                ),
              ),
            );
          },
          backgroundColor: const Color.fromARGB(255, 36, 160, 41),
          child: const Text('Add New Employees'),
        ),
      ),
    );
  }
}

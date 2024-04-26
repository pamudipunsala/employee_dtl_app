import 'package:employee_dtl_app/Pages/edit_dtl.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayDetails extends StatefulWidget {
  @override
  _DisplayDetailsState createState() => _DisplayDetailsState();
}

class _DisplayDetailsState extends State {
  late List<Map<String, dynamic>> mergedData;

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
      employeeList.add(data);
    }
    setState(() {
      mergedData = employeeList;
    });
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
                Text('Salary: ${employee['salary']}'),
                const SizedBox(height: 16.0),
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
                    ;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 36, 160, 41),
                  ),
                  child: const Text('Edit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

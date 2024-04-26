import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EmployeeDtl extends StatefulWidget {
  final VoidCallback refreshData;

  const EmployeeDtl(
      {Key? key,
      required this.refreshData,
      required Future<void> Function() updateCallback})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeDtlState createState() => _EmployeeDtlState();
}

class _EmployeeDtlState extends State<EmployeeDtl> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _salaryController = TextEditingController();
  final _contactNoController = TextEditingController();

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final position = _positionController.text;
      final department = _departmentController.text;
      final contactNumber = _contactNoController.text;
      final salary = _salaryController.text;

      
      await FirebaseFirestore.instance.collection('employees').add({
        'name': name,
        'position': position,
        'department': department,
        'contactNumber': contactNumber,
        'salary': salary,
      });

      
      _nameController.clear();
      _positionController.clear();
      _departmentController.clear();
      _contactNoController.clear();
      _salaryController.clear();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details added successfully!'),
        ),
      );

      widget.refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee Details'),
        backgroundColor: const Color.fromARGB(255, 36, 160, 41),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _positionController,
                decoration: const InputDecoration(labelText: 'Position'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your position';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your department';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _salaryController,
                decoration: const InputDecoration(labelText: 'Salary'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your salary';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _contactNoController,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your contact number';
                  } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _submitForm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 36, 160, 41),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

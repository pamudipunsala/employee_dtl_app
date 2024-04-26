import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class EditEmployeeDetails extends StatefulWidget {
  final String documentId;
  final String name;
  final String position;
  final String department;
  final String contactNumber;
  final String salary;

  const EditEmployeeDetails({
    Key? key,
    required this.documentId,
    required this.name,
    required this.position,
    required this.department,
    required this.contactNumber,
    required this.salary,
  }) : super(key: key);

  @override
  _EditEmployeeDetailsState createState() => _EditEmployeeDetailsState();
}

class _EditEmployeeDetailsState extends State<EditEmployeeDetails> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _salaryController = TextEditingController();
  final _contactNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _positionController.text = widget.position;
    _departmentController.text = widget.department;
    _salaryController.text = widget.salary;
    _contactNoController.text = widget.contactNumber;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final position = _positionController.text;
      final department = _departmentController.text;
      final contactNumber = _contactNoController.text;
      final salary = _salaryController.text;

      await FirebaseFirestore.instance
          .collection('employees')
          .doc(widget.documentId)
          .update({
        'name': name,
        'position': position,
        'department': department,
        'contactNumber': contactNumber,
        'salary': salary,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details updated successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Employee Details'),
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
                onPressed: _submitForm,
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

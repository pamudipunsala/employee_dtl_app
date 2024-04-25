import 'package:employee_dtl_app/Pages/edit_dtl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class EmployeeDtl extends StatefulWidget {
  const EmployeeDtl({Key? key, required String title,});

  @override
  // ignore: library_private_types_in_public_api
  _EmployeeDtlState createState() => _EmployeeDtlState();
}

class _EmployeeDtlState extends State<EmployeeDtl>{
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _departmentController = TextEditingController();
  final _salaryController = TextEditingController();
  final _contactNoController = TextEditingController();
  
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final position = _positionController.text;
      final department = _departmentController.text;
      final contactNumber = _contactNoController.text;
      final salary = _salaryController.value;

      // Clear text fields and reset subject
      _nameController.clear();
      _positionController.clear();
      _departmentController.clear();
      _contactNoController.clear();
      _salaryController.clear();

      // Show a success message
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Details added successfully!'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee Details'),
        backgroundColor:
            const Color.fromARGB(255, 36, 160, 41), // App bar background color
        elevation: 0, // Remove app bar shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Add a back arrow icon
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
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 36, 160, 41), // Set the background color
                ),
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to the "Inquiry" page
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditEmployeeDtl(title: '',),
                    ),
                  );
                },
                child: Text('Edit Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

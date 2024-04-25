import 'package:flutter/material.dart';

class DisplayEmployeeList extends StatelessWidget {
  final String name;
  final String position;
  final String department;
  final String contactNumber;
  final double salary;

  const DisplayEmployeeList({
    super.key,
    required this.name,
    required this.position,
    required this.department,
    required this.contactNumber,
    required this.salary,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inquiry Details'),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('First Name: $name'),
            Text('Last Name: $position'),
            Text('department: $department'),
            Text('Phone Number: $contactNumber'),
            Text('salary: $salary'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 36, 160, 41), // Set the background color
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayInquiryList extends StatelessWidget {
  const DisplayInquiryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inquiry List'),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('inquiries').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final inquiries = snapshot.data!.docs;

          return ListView.builder(
            itemCount: inquiries.length,
            itemBuilder: (context, index) {
              final inquiry = inquiries[index];
              final name = inquiry['First Name'];
              final position = inquiry['Last Name'];
              final department = inquiry['department'];
              final contactNumber = inquiry['Phone Number'];
              final salary = inquiry['salary'];

              return ListTile(
                subtitle: Text(department),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayEmployeeList(
                        name: name,
                        position: position,
                        department: department,
                        contactNumber: contactNumber,
                        salary: salary,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
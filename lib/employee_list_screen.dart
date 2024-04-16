import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'employee.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black,
            ),
            child: const Text(
              'Employee List',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('employees').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No employees found.'));
          } else {
            final employees = snapshot.data!.docs
                .map((doc) => Employee.fromSnapshot(doc))
                .toList();

            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                final isMoreThanFiveYears = DateTime.now().isAfter(employee.joinDate.add(const Duration(days: 365 * 5)));
                final isActive = employee.isActive;





                return Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: Text(employee.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Join Date: ${employee.joinDate.toString()}'),
                        Text('Employee ID: ${employee.employeeId}'),
                        Text('Job Title: ${employee.jobTitle}'),
                      ],
                    ),
                    trailing: isMoreThanFiveYears && isActive
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

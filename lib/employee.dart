import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String name;
  final DateTime joinDate;
  final bool isActive;
  final int employeeId;
  final String jobTitle;

  Employee({
    required this.name,
    required this.joinDate,
    required this.isActive,
    required this.employeeId,
    required this.jobTitle,
  });

  factory Employee.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Employee(
      name: data['name'] ?? '',
      joinDate: (data['joinDate'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? false,
      employeeId: data['employeeId'] ?? 0,
      jobTitle: data['jobTitle'] ?? '',
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthsync/features/user_auth/pages/appointment.dart';

class ListDoctor extends StatelessWidget {
  final String userId;

  const ListDoctor({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Doctors'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('UserDetails')
            .where('userType', isEqualTo: 'Doctor')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final doctors = snapshot.data!.docs;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                final fullName = doctor['fullName'] ?? '';
                final workExperience = doctor['workExperience'] ?? '';
                final specialty = doctor['specialty'] ?? '';

                return ListTile(
                  title: Text(fullName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Work Experience: $workExperience'),
                      Text('Specialty: $specialty'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      print("fullname "+fullName);
                      Navigator.pushNamed(
                        context,
                       '/appointment',
                        arguments: {
                          'userId': userId,
                          'doctorId': doctor.id,
                          'doctorName':fullName,
                        },
                      );
                    },
                    child: Text('Book'),
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

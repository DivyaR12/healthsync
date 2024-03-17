import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:healthsync/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import '../../../global/toast.dart';

class AppointmentDet extends StatefulWidget {
  final String userId;
  final String doctorId;
  final String doctorName;

  const AppointmentDet({
    super.key,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
  });
  
  
  @override
  State<AppointmentDet> createState() => _AppointmentDetState();
}

class _AppointmentDetState extends State<AppointmentDet> {
  
  late String _userId=widget.userId;
  late String _docId=widget.doctorId;
  late String _docName=widget.doctorName;
  

  DateTime selectedDate = DateTime.now();
  String selectedTime = '9:00';
  String selectedMinutes = '0';

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024, 12, 31),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveAppointmentDetails() async {
    
    final userId = widget.userId;
    final doctorId = widget.doctorId;
    final doctorName = widget.doctorName;
    print("widget "+_userId);
    await FirebaseFirestore.instance.collection('Appointments').add({
       'userId': userId,
       'doctorId': doctorId,
       'doctorName': doctorName,
       'selectedDate': selectedDate.toUtc(), // Saving date in UTC timezone
      'selectedTime': selectedTime,
       'selectedMinutes': selectedMinutes,
       'createdAt': DateTime.now().toUtc(), // Saving creation time in UTC timezone
     });
    print('Appointment details saved.');
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Doctor Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Text(
                widget.doctorName,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Appointment Date:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectDate(context);
                },
                child: Text('Select Date'),
              ),
              Text(
                'Selected Date: ${selectedDate.toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Appointment Time:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  DropdownButton<String>(
                    value: selectedTime,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTime = newValue!;
                      });
                    },
                    items: List.generate(
                      9,
                      (index) => DropdownMenuItem(
                        value: '${index + 9}:00',
                        child: Text('${index + 9}:00'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedMinutes,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMinutes = newValue!;
                      });
                    },
                    items: ['0', '15', '30', '45'].map<DropdownMenuItem<String>>(
                      (value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  saveAppointmentDetails();
                  Navigator.pushNamed(context, '/home',arguments: _userId);
                  showToast(message: "Appointment booked successfully");
                },
                child: Text('Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
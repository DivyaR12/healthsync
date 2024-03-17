import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../global/toast.dart';


class UpcomingAppointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Here you can implement logic to fetch upcoming appointments
    // and display them in a list. For demonstration purposes,
    // I'm just showing a placeholder text.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Appointments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment 1 - Dr Divya',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Appointment 2 - Dr Divya',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  // Add more appointments here if needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

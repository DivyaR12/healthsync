
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthsync/features/user_auth/widgets/form_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../global/toast.dart';


class FormContainerWidget extends StatefulWidget {
  final bool showSidebar;
  final Widget content;

  const FormContainerWidget({
    Key? key,
    required this.showSidebar,
    required this.content,
  }) : super(key: key);

  @override
  _FormContainerWidgetState createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Home"),
        leading: widget.showSidebar
            ? IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Toggle sidebar visibility
                  // Here, you can implement logic to show/hide the sidebar
                },
              )
            : null,
      ),
      body: Row(
        children: [
          if (widget.showSidebar) Sidebar(), // Show sidebar if needed
          Expanded(child: widget.content),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.grey[200],
      // Sidebar content
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with text on top
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../../../../assets/Healthsync.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Solution for all your health needs",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          // Columns for upcoming appointments, prescriptions, and update medical history
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 1st column - Upcoming appointments
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Upcoming Appointments",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppointmentRow(
                      doctor: "Dr. Jack",
                      address: "123 Main St, City",
                      date: "30 March, 2pm",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // View more appointments
                      },
                      child: Text("View More"),
                    ),
                  ],
                ),
                // 2nd column - Prescriptions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Prescriptions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppointmentRow(
                      doctor: "Dr. XYZ",
                      address: "456 Elm St, Town",
                      date: "30 March, 2pm",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // View more prescriptions
                      },
                      child: Text("View More"),
                    ),
                  ],
                ),
                // 3rd column - Update medical history
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update Medical History",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Upload new document
                      },
                      child: Text("Upload New Document"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentRow extends StatelessWidget {
  final String doctor;
  final String address;
  final String date;

  const AppointmentRow({
    required this.doctor,
    required this.address,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctor,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(address),
            ],
          ),
        ),
        Text(date),
      ],
    );
  }
}

class PatientHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patient Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormContainerWidget(
        showSidebar: false, // Change to true for sidebar
        content: HomePageContent(),
      ),
    );
  }
}

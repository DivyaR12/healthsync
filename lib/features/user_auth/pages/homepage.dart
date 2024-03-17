

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthsync/features/user_auth/widgets/form_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../global/toast.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:healthsync/features/user_auth/pages/upcomingappointment.dart';
import 'package:healthsync/features/user_auth/pages/sidebar.dart';

 class ImageDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context)!.settings.arguments as String;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Welcome to HealthSync'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Handle Home item tap
              },
            ),
            ListTile(
              title: Text('Search'),
              onTap: () {
                Navigator.pushNamed(context, '/listdoctor', arguments: userId);

              },
            ),
            ListTile(
              title: Text('History'),
              onTap: () {
                // Handle History item tap
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: UpcomingAppointments(),
      ),
    );
  }
}
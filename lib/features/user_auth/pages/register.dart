import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:healthsync/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import '../../../global/toast.dart';

class UserDetailsForm extends StatefulWidget {
  const UserDetailsForm({Key? key}) : super(key: key);

  @override
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String _userType = 'Patient'; // Default value
  String _age = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  bool _isAbove13 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Your Profile")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            DropdownButtonFormField<String>(
              value: _userType,
              onChanged: (newValue) {
                setState(() {
                  _userType = newValue!;
                });
              },
              items: <String>['Patient', 'Doctor']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Age'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                return null;
              },
              onChanged: (value) => _age = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address Line 1'),
              onChanged: (value) => _addressLine1 = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Address Line 2'),
              onChanged: (value) => _addressLine2 = value,
            ),
            CheckboxListTile(
              title: const Text("I confirm that I am 13 years of age or older."),
              value: _isAbove13,
              onChanged: (newValue) {
                setState(() {
                  _isAbove13 = newValue!;
                });
              },
            ),
           ElevatedButton(
            onPressed: _isAbove13? () {
          // Check if _isAbove13 is true and form is validated
              if (_formKey.currentState!.validate()) {
            // Navigate to home page
                 Navigator.pushReplacementNamed(context, '/home');
              }
            }: null,
       style: ElevatedButton.styleFrom(
      primary: _isAbove13 ? Colors.blue : Colors.grey,
      ),
      child: const Text('Submit'),
          ),


     ]  ,
        ),
      ),
    );
  }

  Future<void> _saveUserDetails() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _isAbove13) {
       await FirebaseFirestore.instance.collection('UserDetails').doc(userId).set({
        'userType': _userType,
        'age': _age,
        'addressLine1': _addressLine1,
        'addressLine2': _addressLine2,
        'isAbove13': _isAbove13,
      });
      
      // Navigate to the next page or show success message
      print('Navigating to home page');
      Navigator.pushNamed(context, '/home');
    } else {
      // Handle the case where userId is null or user is not above 13
      // This could involve showing an error message or taking some other action
      if(!_isAbove13){
      showToast(message: "User is not above 13 years");
      }
      else{
           showToast(message: "Some error happened");
      }
    }
  }
}

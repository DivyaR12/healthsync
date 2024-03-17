import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:healthsync/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../global/toast.dart';

class UserDetailsForm extends StatefulWidget {
  const UserDetailsForm({Key? key}) : super(key: key);

  @override
  State<UserDetailsForm> createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String _fullname='';
  String _userType = 'Patient'; // Default value
  String _age = '';
  String _addressLine1 = '';
  String _addressLine2 = '';
  String _pinCode = '';
  bool _isAbove13 = false;
  bool _isDoctor = false;
  String _hospitalClinicName = '';
  String _qualification = 'MBBS';
  String _workExperience = '';
  String _bio = '';
  String _specialty = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("")),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text('User Registration ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Full Name *'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onChanged: (value) => _fullname = value,
                  ),
                  DropdownButtonFormField<String>(
                    value: _userType,
                    onChanged: (newValue) {
                      setState(() {
                        _userType = newValue!;
                        _isDoctor = _userType == 'Doctor';
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
                    decoration: const InputDecoration(labelText: 'Age *'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => _age = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Address Line 1 *'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    onChanged: (value) => _addressLine1 = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Address Line 2'),
                    onChanged: (value) => _addressLine2 = value,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Pin Code *'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your pin code';
                      }
                      return null;
                    },
                    onChanged: (value) => _pinCode = value,
                  ),
                  
                  if (_isDoctor) ...[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Hospital/Clinic Name *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the hospital/clinic name';
                        }
                        return null;
                      },
                      onChanged: (value) => _hospitalClinicName = value,
                    ),
                    DropdownButtonFormField<String>(
                      value: _qualification,
                      onChanged: (newValue) {
                        setState(() {
                          _qualification = newValue!;
                        });
                      },
                      items: <String>['MBBS', 'MD', 'Dentist']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Work Experience *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your work experience in years';
                        }
                        return null;
                      },
                      onChanged: (value) => _workExperience = value,
                    ),
                    TextFormField(
                    decoration: const InputDecoration(labelText: 'Specialty'),
                    onChanged: (value) => _specialty= value,
                  ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Bio *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your bio';
                        }
                        return null;
                      },
                      onChanged: (value) => _bio = value,
                    ),
                  ],
                    Row(
                    children: [
                      Checkbox(
                        value: _isAbove13,
                        onChanged: (newValue) {
                          setState(() {
                            _isAbove13 = newValue!;
                          });
                        },
                      ),
                      Text("I confirm that I am 13 years of age or older."),
                    ],
                  ),
                    
                    
                  ElevatedButton(
                    onPressed: _isAbove13
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              
                              _saveUserDetails();
                            }
                          }
                        : null,
                    
                    style: ElevatedButton.styleFrom(
                       minimumSize: Size(double.infinity, 50),
                       
                      primary: _isAbove13 ? Colors.blue : Colors.grey,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
 Future<void> _saveUserDetails() async {
  final String userId = ModalRoute.of(context)!.settings.arguments as String;

  try {
    if (userId.isNotEmpty && _isAbove13) {
      if (!_isDoctor){
      await FirebaseFirestore.instance.collection('UserDetails').doc(userId).set({
        'fullname':_fullname,
        'userType': _userType,
        'age': _age,
        'addressLine1': _addressLine1,
        'addressLine2': _addressLine2,
        '_pinCode':_pinCode,
        'isAbove13': _isAbove13,
      });
      // Navigate to the next page or show success message
      print('Navigating to patient home page');
      Navigator.pushReplacementNamed(context, '/home', arguments: userId );
      }
      else{
        await FirebaseFirestore.instance.collection('UserDetails').doc(userId).set({
        'fullname':_fullname,
        'userType': _userType,
        'age': _age,
        'addressLine1': _addressLine1,
        'addressLine2': _addressLine2,
        'pinCode':_pinCode,
        'hospitalClinicName': _hospitalClinicName,
        'qualification':_qualification,
        'workExperience': _workExperience,
        'bio':_bio,
        'rating':'',
        'feedback':'',
        'specialty':_specialty,
        'isAbove13': _isAbove13,
      });
      // Navigate to the next page or show success message
      print('Navigating to doctor home page');
      Navigator.pushReplacementNamed(context, '/home', arguments: userId);

      }
      
      
    } else {
      // Handle the case where userId is null or user is not above 13
      // This could involve showing an error message or taking some other action
      if(!_isAbove13){
        showToast(message: "User is not above 13 years");
      } else {
        showToast(message: "Some error happened");
      }
    }
  } catch (e) {
    print('Firestore error: $e');
    showToast(message: "Firestore error occurred");
  }
}


}

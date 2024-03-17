import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  final String name;
  final DateTime time;
  final String service;
  String status;
  final String? id;

  Appointment(
      {required this.name, required this.time, required this.service, required this.status, this.id, required Map<dynamic, String> arguments});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        name: json['name'],
        time: (json['time']).toDate(),
        service: json['service'],
        status: json['status'],
        id: json['id'], arguments: {});
  }

  toJson() {
    return {
      'name': name,
      'service': service,
      'time': Timestamp.fromDate(time),
      'status': status,
      'id': id
    };
  }
}

class Prescrition {
  final String PaitentId;
  final String DoctorId;
  final String AppoId;
  final String PrescritionId;
  final String MedicalResons;
  final DateTime  HPD_Date;
  final DateTime HPD_DateTime;
  final String HPD_SBP;
  final String HPD_DBP;
  final String HPD_HeartRate;
  final String HPD_BloodGlucose;
  final String HPD_GlucoseMeasured;
  final String HPD_Height;
  final String HPD_BMI;
  final String HPD_Type;
  final String HPD_Medication;
  final String? id;

  Prescrition(
   {required this.PaitentId,required this.DoctorId,required this.AppoId,required this.PrescritionId,
               required this.MedicalResons,required this.HPD_Date,required this.HPD_DateTime,required this.HPD_HeartRate,required this.HPD_SBP,required this.HPD_DBP
               ,required this.HPD_BloodGlucose,required this.HPD_GlucoseMeasured,required this.HPD_Height,required this.HPD_BMI,required this.HPD_Type,required this.HPD_Medication,
              this.id, required Map<dynamic, String> arguments});

  
factory Prescrition.fromJson(Map<String, dynamic> json) {
    return Prescrition(
     PaitentId:json['PaitentId'],
     DoctorId: json['DoctorId'],
     AppoId: json['AppoId'],
     PrescritionId: json['PrescritionId'],
     MedicalResons: json['MedicalResons'],
     HPD_Date: (json['HPD_Date']).toDate(),
     HPD_DateTime: (json['HPD_DateTime']).toDate(),
     HPD_SBP: json['HPD_SBP'],
     HPD_DBP: json['HPD_DBP'],
     HPD_HeartRate: json['HPD_HeartRate'],
     HPD_BloodGlucose: json['HPD_BloodGlucose'],
     HPD_GlucoseMeasured: json['HPD_GlucoseMeasured'],
     HPD_Height: json['HPD_Height'],
     HPD_BMI: json['HPD_BMI'],
     HPD_Type: json['HPD_Type'],
      HPD_Medication: json['HPD_Medication'],
    id: json['id'], arguments: {});
  } 
  toJson() {
    return {
        'PaitentId': PaitentId,
        'DoctorId': DoctorId,
        'AppoId': AppoId,
        'PrescritionId': PrescritionId,
        'HPD_Date': Timestamp.fromDate(HPD_Date),
        'HPD_DateTime': Timestamp.fromDate(HPD_DateTime),
        'HPD_SBP': HPD_SBP,
        'HPD_DBP': HPD_DBP,
        'HPD_HeartRate': HPD_HeartRate,
        'HPD_Medication': HPD_Medication,
        'HPD_BloodGlucose': HPD_BloodGlucose,
        'HPD_GlucoseMeasured': HPD_GlucoseMeasured,
        'HPD_Height':HPD_Height,
        'HPD_BMI': HPD_BMI,
        'HPD_Type': HPD_Type,
         'id': id
    };
  }
}


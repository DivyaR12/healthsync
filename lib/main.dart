import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Import Firebase Auth
import 'package:healthsync/features/app/splashscreen.dart';
import 'package:healthsync/features/user_auth/pages/appt_model.dart';
import 'package:healthsync/features/user_auth/pages/homepage.dart';
import 'package:healthsync/features/user_auth/pages/login.dart';
import 'package:healthsync/features/user_auth/pages/signup.dart';
import 'package:healthsync/features/user_auth/pages/register.dart';
import 'package:healthsync/features/user_auth/pages/searchdoctor.dart';
import 'package:healthsync/features/user_auth/pages/appointment.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC6GtNW77Gd4bEdbD-5Fbgb59Cc5KIcjso",
        authDomain: "healthsync-c94ff.firebaseapp.com",
        projectId: "healthsync-c94ff",
        storageBucket: "healthsync-c94ff.appspot.com",
        messagingSenderId: "53901590437",
        appId: "1:53901590437:web:124f541b36d8cb6166f24c"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => const SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/register':  (context) => const UserDetailsForm(),
        '/home': (context) =>  ImageDisplay(),
        '/listdoctor':(context) =>  const ListDoctor(userId:''),
        '/appointment': (context) => AppointmentDet(userId: '', doctorId: '', doctorName: ''),
        /*'/appointment':(context) => MaterialPageRoute(
              builder: (context) => Appointment(
                userId: '',
                doctorId: '',
                doctorName: '',
              ),
            ),*/
      },
    );
  }
}
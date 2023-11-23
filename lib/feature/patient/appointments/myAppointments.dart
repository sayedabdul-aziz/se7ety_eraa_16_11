import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/feature/patient/appointments/myAppointmentList.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مواعيد الحجز',
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: MyAppointmentList(),
      ),
    );
  }
}

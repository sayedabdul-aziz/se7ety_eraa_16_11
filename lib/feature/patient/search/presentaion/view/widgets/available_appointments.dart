import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentService {
  // final CollectionReference appointments =
  //     FirebaseFirestore.instance.collection('appointments');
  final CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');

  Future<List<DateTime>> getAvailableAppointments(
      DateTime selectedDate, String start, String end) async {
    // تحديد مواعيد العمل لليوم المحدد
    int startHour = int.parse(start);
    int endHour = int.parse(end);
    DateTime startDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      startHour,
    );
    DateTime endDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      endHour,
    );

    // // استعلام Firestore للحصول على المواعيد المحجوزة
    // QuerySnapshot snapshot = await appointments
    //     .where('doctorId', isEqualTo: doctorId)
    //     .where('dateTime', isGreaterThanOrEqualTo: startDateTime)
    //     .where('dateTime', isLessThan: endDateTime)
    //     .get();

    // تحديد المواعيد المتاحة
    List<DateTime> availableAppointments = [];
    for (int i = startHour; i < endHour; i++) {
      DateTime candidateTime =
          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, i);
      // if (!snapshot.docs
      //     .any((doc) => (doc['dateTime'] as Timestamp).toDate().hour == i)) {
      availableAppointments.add(candidateTime);
      // }
    }

    return availableAppointments;
  }
}

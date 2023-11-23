import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';

class AppointmentHistoryList extends StatefulWidget {
  const AppointmentHistoryList({super.key});

  @override
  _AppointmentHistoryListState createState() => _AppointmentHistoryListState();
}

class _AppointmentHistoryListState extends State<AppointmentHistoryList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  String? _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  Future<void> deleteAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc(user?.email.toString())
        .collection('all')
        .doc(docID)
        .delete();
  }

  String _dateFormatter(String timestamp) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(DateTime.parse(timestamp));
    return formattedDate;
  }

  String _timeFormatter(String timestamp) {
    String formattedTime =
        DateFormat('hh:mm a').format(DateTime.parse(timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        deleteAppointment(_documentID!);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this Appointment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _checkDiff(DateTime date) {
    var diff = DateTime.now().difference(date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String date) {
    if (_dateFormatter(DateTime.now().toString())
            .compareTo(_dateFormatter(date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('appointments')
            .doc('appointments')
            .collection('all')
            .where('patientID', isEqualTo: '${user!.email}')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'لا يوجد حجوزات سابقة',
                style: getbodyStyle(),
              ),
            );
          }
          return snapshot.data?.size == 0
              ? Center(
                  child: Text(
                    'لا يوجد حجوزات سابقة',
                    style: getbodyStyle(),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    print(_compareDate(document['date'].toDate().toString()));
                    // if (_checkDiff(document['date'].toDate())) {
                    //   deleteAppointment(document.id);
                    // }
                    return Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBG,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(-3, 0),
                                blurRadius: 15,
                                color: Colors.grey.withOpacity(.1),
                              )
                            ],
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: ExpansionTile(
                              childrenPadding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.end,
                              backgroundColor: AppColors.scaffoldBG,
                              collapsedBackgroundColor: AppColors.scaffoldBG,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      'د. ${document['doctor']}',
                                      style: getTitleStyle(),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5, left: 5),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month_rounded,
                                            color: AppColors.color1, size: 16),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _dateFormatter(document['date']
                                              .toDate()
                                              .toString()),
                                          style: getbodyStyle(),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          _compareDate(document['date']
                                                  .toDate()
                                                  .toString())
                                              ? "اليوم"
                                              : "",
                                          style: getbodyStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.watch_later_outlined,
                                            color: AppColors.color1, size: 16),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _timeFormatter(
                                            document['date']
                                                .toDate()
                                                .toString(),
                                          ),
                                          style: getbodyStyle(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, right: 10, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "اسم المريض: " + document['name'],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "اسم المستشفي: " + document['hospital'],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_rounded,
                                              color: AppColors.color1,
                                              size: 16),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            document['location'],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.redColor),
                                            onPressed: () {
                                              _documentID = document.id;
                                              showAlertDialog(context);
                                            },
                                            child: const Text('حذف الحجز')),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}

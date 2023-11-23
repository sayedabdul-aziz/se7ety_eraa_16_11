import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';
import 'package:se7ety_eraa_16_11/core/widgets/doctor_card.dart';
import 'package:se7ety_eraa_16_11/feature/patient/search/presentaion/view/doctor_profile.dart';

class ExploreList extends StatefulWidget {
  final String specialization;
  const ExploreList({Key? key, required this.specialization}) : super(key: key);

  @override
  _ExploreListState createState() => _ExploreListState();
}

class _ExploreListState extends State<ExploreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.specialization,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('specialization')
            .startAt([widget.specialization]).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/no-search.svg',
                          width: 250,
                        ),
                        Text(
                          'لا يوجد دكتور بهذا التخصص حاليا',
                          style: getbodyStyle(),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data?.size,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doctor = snapshot.data!.docs[index];
                      return DoctorCard(
                          name: doctor['name'],
                          image: doctor['image'],
                          specialization: doctor['specialization'],
                          rating: doctor['rating'],
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorProfile(
                                  doctor: doctor['name'],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                );
        },
      ),
    );
  }
}

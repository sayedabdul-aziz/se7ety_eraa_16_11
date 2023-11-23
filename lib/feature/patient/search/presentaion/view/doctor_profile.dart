import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_colors.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';
import 'package:se7ety_eraa_16_11/core/widgets/custom_button.dart';
import 'package:se7ety_eraa_16_11/core/widgets/tile_widget.dart';
import 'package:se7ety_eraa_16_11/feature/patient/search/data/doctor_model.dart';
import 'package:se7ety_eraa_16_11/feature/patient/search/presentaion/view/booking_view.dart';
import 'package:se7ety_eraa_16_11/feature/patient/search/presentaion/view/widgets/contact_icon.dart';

class DoctorProfile extends StatefulWidget {
  final String? doctor;

  const DoctorProfile({Key? key, this.doctor}) : super(key: key);
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late Doctor doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات الدكتور'),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .orderBy('name')
            .startAt([widget.doctor]).endAt(
                ['${widget.doctor!}\uf8ff']).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var userData = snapshot.data!.docs.first;
          doctor = Doctor(
              name: userData['name'],
              imageUrl: userData['image'],
              specialization: userData['specialization'],
              rating: userData['rating'],
              email: userData['email'],
              startHour: userData['openHour'],
              endHour: userData['closeHour'],
              location: userData['address']);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // ------------ Header ---------------
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColors.white,
                          child: CircleAvatar(
                            backgroundColor: AppColors.white,
                            radius: 60,
                            backgroundImage: (userData['image'] != null)
                                ? NetworkImage(userData['image'])
                                    as ImageProvider
                                : const AssetImage('assets/doc.png'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "د. ${userData['name']}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: getTitleStyle(),
                          ),
                          Text(
                            userData['specialization'],
                            style: getbodyStyle(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                userData['rating'].toString(),
                                style: getbodyStyle(),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              IconTile(
                                onTap: () {},
                                backColor: AppColors.scaffoldBG,
                                imgAssetPath: Icons.phone,
                                num: '1',
                              ),
                              if (userData['phone2'] != null)
                                IconTile(
                                  onTap: () {},
                                  backColor: AppColors.scaffoldBG,
                                  imgAssetPath: Icons.phone,
                                  num: '2',
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "نبذه تعريفية",
                  style: getbodyStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userData['bio'],
                  style: getsmallStyle(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.scaffoldBG,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(
                          text:
                              '${userData['openHour']} - ${userData['closeHour']}',
                          icon: Icons.watch_later_outlined),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(
                          text: userData['address'],
                          icon: Icons.location_on_rounded),
                    ],
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "معلومات الاتصال",
                  style: getbodyStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.scaffoldBG,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TileWidget(text: userData['email'], icon: Icons.email),
                      const SizedBox(
                        height: 15,
                      ),
                      TileWidget(text: userData['phone1'], icon: Icons.call),
                      const SizedBox(
                        height: 15,
                      ),
                      if (userData['phone2'] != null)
                        TileWidget(text: userData['phone2'], icon: Icons.call),
                    ],
                  ),
                ),
              ],
            )),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomButton(
          text: 'احجز موعد الان',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingView(doctor: doctor),
              ),
            );
          },
        ),
      ),
    );
  }
}

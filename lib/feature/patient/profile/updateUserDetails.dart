import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_eraa_16_11/core/utils/app_text_styles.dart';
import 'package:se7ety_eraa_16_11/feature/patient/profile/userSettings.dart';

class UpdateUserDetails extends StatefulWidget {
  final String label;
  final String field;
  const UpdateUserDetails({Key? key, required this.label, required this.field})
      : super(key: key);

  @override
  _UpdateUserDetailsState createState() => _UpdateUserDetailsState();
}

class _UpdateUserDetailsState extends State<UpdateUserDetails> {
  final TextEditingController _textcontroller = TextEditingController();
  FocusNode? f1;
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
        backgroundColor: Colors.white,
        elevation: 2,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo,
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: getbodyStyle(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('patients')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: _textcontroller,
                    style: getbodyStyle(),
                    onFieldSubmitted: (String data) {
                      _textcontroller.text = data;
                    },
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the ${widget.label}';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    updateData();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.indigo.withOpacity(0.9),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: getbodyStyle(),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> updateData() async {
    FirebaseFirestore.instance.collection('patients').doc(user?.uid).set({
      widget.field: _textcontroller.text,
    }, SetOptions(merge: true));
    if (widget.field.compareTo('name') == 0) {
      await user?.updateDisplayName(_textcontroller.text);
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const UserSettings()));
  }
}

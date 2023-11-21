import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_eraa_16_11/feature/auth/presentation/view_model/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  login() {}

  registerDoctor() {}

  registerPatient(String name, String email, String password) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;

      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('patients').doc(user.uid).set({
        'name': name,
        'image': null,
        'age': null,
        'email': email,
        'phone': null,
        'bio': null,
        'city': null,
      }, SetOptions(merge: true));
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AuthFailureState(error: 'يوجد حساب بالفعل علي هذا الايميل'));
      } else if (e.code == 'weak-password') {
        emit(AuthFailureState(error: 'كلمة السر التي ادخلتها ضعيفة جدا'));
      } else {
        emit(AuthFailureState(error: e.toString()));
      }
    }
  }
}


//  'name': name,
//         'image': null,
//         'specialization': null,
//         'rating': null,
//         'email': user.email,
//         'phone1': null,
//         'phone2': null,
//         'bio': null,
//         'openHour': null,
//         'closeHour': null,
//         'address': null,

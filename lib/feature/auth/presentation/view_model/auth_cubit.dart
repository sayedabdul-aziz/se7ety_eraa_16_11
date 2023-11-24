import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_eraa_16_11/feature/auth/presentation/view_model/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  login(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureState(error: 'لا يوجد حساب علي هذا الايميل'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureState(error: 'كلمة السر التي ادخلتها غير صحيحة'));
      } else {
        emit(AuthFailureState(error: 'حدثت مشكلة في تسجيل الدخول حاول لاحقاً'));
      }
    }
  }

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

  registerDoctor(String name, String email, String password) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user!;

      await user.updateDisplayName(name);

      FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': name,
        'image': null,
        'specialization': null,
        'rating': null,
        'email': user.email,
        'phone1': null,
        'phone2': null,
        'bio': null,
        'openHour': null,
        'closeHour': null,
        'address': null,
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

  updateDoctorData(
      {required String uid,
      required String specialization,
      required String image,
      required String email,
      required String phone1,
      String? phone2,
      required String bio,
      required String startTime,
      required String endTime,
      required String address}) async {
    emit(UpdateLoadingState());
    try {
      FirebaseFirestore.instance.collection('doctors').doc(uid).set({
        'image': image,
        'specialization': specialization,
        'rating': 3,
        'phone1': phone1,
        'phone2': phone2,
        'bio': bio,
        'openHour': startTime,
        'closeHour': endTime,
        'address': address,
      }, SetOptions(merge: true));
      emit(UpdateSucessState());
    } catch (e) {
      emit(UpdateErrorState(error: e.toString()));
    }
  }
}

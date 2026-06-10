import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'edit_profile_states.dart';

@singleton
class EditProfileCubit extends Cubit<EditProfileStates> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> updateProfile({
    required String userId,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(EditProfileLoading());
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'name': name,
        'phone': phone,
        'avatar': avatar,
      });
      emit(EditProfileSuccess());
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }

  Future<void> deleteAccount({required String userId}) async {
    emit(EditProfileLoading());
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      await FirebaseAuth.instance.currentUser?.delete();
      emit(DeleteAccountSuccess());
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }
}

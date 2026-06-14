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

  Future<void> deleteAccount(
      {required String userId, required String password}) async {
    emit(EditProfileLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      await user.delete();

      emit(DeleteAccountSuccess());
    } on FirebaseAuthException catch (e) {
      emit(EditProfileError(message: e.message ?? 'Failed to delete account'));
    } catch (e) {
      emit(EditProfileError(message: e.toString()));
    }
  }
}

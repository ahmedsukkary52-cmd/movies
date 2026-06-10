import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../domain/data_sources/remote/auth_remote_data_source.dart';
import '../../../domain/entities/user.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(this._auth, this._googleSignIn);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserEntity(
        id: result.user!.uid,
        email: result.user!.email!,
        name: result.user!.displayName,
        photoUrl: result.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(message: e.message ?? 'Login failed');
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(
        message: e.message ?? 'Failed to send reset email',
      );
    }
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw ServerExceptions(message: 'Cancelled');
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _auth.signInWithCredential(credential);

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .get();

      if (!doc.exists) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
              'name': result.user!.displayName,
              'email': result.user!.email,
              'phone': '',
              'avatar': 'assets/images/g1.png',
            });
      }

      return UserEntity(
        id: result.user!.uid,
        email: result.user!.email!,
        name: result.user!.displayName,
        photoUrl: result.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(message: e.message ?? 'Google login failed');
    }
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({
            'name': name,
            'email': email,
            'phone': phone,
            'avatar': avatar,
          });
      return UserEntity(
        id: result.user!.uid,
        email: email,
        name: name,
        photoUrl: avatar,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerExceptions(message: e.message ?? 'Register failed');
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }
}

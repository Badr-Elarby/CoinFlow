import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_7/core/networking/firebase_error_handler.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception('User creation failed');
      }

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handle(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
  //
  // @override
  // Future<void> updateDisplayName(User user, String displayName) async {
  //   try {
  //     await user.updateDisplayName(displayName);
  //     throw Exception('User name creation failed');
  //   } on FirebaseAuthException catch (e) {
  //     throw FirebaseErrorHandler.handle(e.code);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }
  //
  // @override
  // Future<void> reloadUser(User user) async {
  //   try {
  //     await user.reload();
  //     throw Exception('User reload failed');
  //   } on FirebaseAuthException catch (e) {
  //     throw FirebaseErrorHandler.handle(e.code);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      throw Exception('User sign out failed');
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handle(e.code);
    } catch (e) {
      throw Exception(e);
    }
  }
}



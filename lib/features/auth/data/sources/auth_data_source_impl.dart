import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_7/features/auth/domain/repository/auth_data_source.dart';

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user == null) {
      throw Exception('User creation failed');
    }
    return userCredential.user!;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    throw Exception('User sign out failed');
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_7/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  });

  Future<UserModel?> getCurrentUser();

  Future<void> signOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthDataSourceImpl(this._firebaseAuth);

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String phone,
  }) async {
    try {
      _validateSignUpInputs(firstName, lastName, email, password, phone);

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fullName = '$firstName $lastName';
      await userCredential.user?.updateDisplayName(fullName);
      await userCredential.user?.reload();
      
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'User not found after sign up',
        );
      }

      return UserModel.fromFirebaseUser(user);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to sign up: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        return UserModel.fromFirebaseUser(user);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: ${e.toString()}');
    }
  }

  void _validateSignUpInputs(
    String firstName,
    String lastName,
    String email,
    String password,
    String phone,
  ) {
    // First name validation
    if (firstName.trim().isEmpty) {
      throw Exception('First name cannot be empty');
    }
    if (firstName.trim().length < 2) {
      throw Exception('First name must be at least 2 characters');
    }

    // Last name validation
    if (lastName.trim().isEmpty) {
      throw Exception('Last name cannot be empty');
    }
    if (lastName.trim().length < 2) {
      throw Exception('Last name must be at least 2 characters');
    }

    // Email validation
    if (email.trim().isEmpty) {
      throw Exception('Email cannot be empty');
    }
    if (!_isValidEmail(email.trim())) {
      throw Exception('Please enter a valid email address');
    }

    // Password validation
    if (password.isEmpty) {
      throw Exception('Password cannot be empty');
    }
    if (password.length < 8) {
      throw Exception('Password must be at least 8 characters');
    }

    // Phone validation
    if (phone.trim().isEmpty) {
      throw Exception('Phone number cannot be empty');
    }
    if (phone.trim().length < 10) {
      throw Exception('Phone number must be at least 10 digits');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}

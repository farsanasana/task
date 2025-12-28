import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// 🔐 LOGIN
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseError(e);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// 🚪 LOGOUT
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  /// 👤 CURRENT USER
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  /// ❌ ERROR HANDLING
  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This user account has been disabled';
      default:
        return e.message ?? 'Authentication failed';
    }
  }
}

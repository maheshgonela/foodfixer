import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodfixer/core/base_cubit.dart';

class PhoneAuthCubit extends AppBaseCubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendVerificationCode(String phoneNumber) async {
    emitSafeState(PhoneAuthLoading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {
          signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          emitSafeState(PhoneAuthError(e.message!));
        },
        codeSent: (String verificationId, int? resendToken) {
          emitSafeState(PhoneAuthCodeSent(verificationId));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseException catch (e) {
      emitSafeState(PhoneAuthError(e.toString()));
    }
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    emitSafeState(PhoneAuthLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await signInWithCredential(credential);
    } on FirebaseException catch (e) {
      emitSafeState(PhoneAuthError(e.toString()));
    }
  }

  Future<void> signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await _auth.signInWithCredential(credential);
      emitSafeState(PhoneAuthSuccess());
    } on FirebaseException catch (e) {
      emitSafeState(PhoneAuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      _auth.signOut().then(
        (value) async {
          print(
              'The user must reauthenticate before this operation can be Execute');
          User? currentUser = FirebaseAuth.instance.currentUser;
          print('currentUser $currentUser');
          if (currentUser != null && currentUser.uid.isNotEmpty) {
            try {
              await currentUser.delete();
              print('User account is deleted Successfully');
            } catch (e) {
              print('Error while deleting the user $e');
            }
          } else {
            print('No authenticated user to delete');
          }
        },
      );
      emitSafeState(PhoneAuthInitial());
    } catch (e) {
      emitSafeState(PhoneAuthError('Sign out failed: ${e.toString()}'));
    }
  }
}

abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class PhoneAuthLoading extends PhoneAuthState {}

class PhoneAuthCodeSent extends PhoneAuthState {
  final String verificationId;
  PhoneAuthCodeSent(this.verificationId);
}

class PhoneAuthError extends PhoneAuthState {
  final String message;
  PhoneAuthError(this.message);
}

class PhoneAuthSuccess extends PhoneAuthState {}

import 'package:bloc_state_management/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  LoginCubit() : super(LoginInitialState());
  String? _verificationId;
  void sendOtp(String phoneNumber) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: ((verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(LoginOtpSentState());
        }),
        verificationCompleted: (phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (error) {
          emit(LoginErrorState(error.message.toString()));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        });
  }

  void verifyOtp(String otp) {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(phoneAuthCredential);
  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential userCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        emit(LoggedInState());
      }
    } on FirebaseAuthException catch (ex) {
      emit(LoginErrorState(ex.message.toString()));
    }
  }
}

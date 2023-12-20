import 'package:bloc_state_management/cubits/auth_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  LoginCubit() : super(LoginInitialState()) {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      emit(LoggedInState(currentUser));
    } else {
      emit(LoggedOutState());
    }
  }
  String? _verificationId;
  void sendOtp(String phoneNumber) async {
    emit(LoginLoadingState());
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
    emit(LoginLoadingState());
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    debugPrint("here");
    signInWithPhone(phoneAuthCredential);
    debugPrint("here 2");
  }

  void signInWithPhone(PhoneAuthCredential phoneAuthCredential) async {
    try {
      UserCredential userCredential =
          await auth.signInWithCredential(phoneAuthCredential);
      if (userCredential.user != null) {
        debugPrint("here 3");

        emit(LoggedInState(userCredential.user!));
        debugPrint("here 4");
      }
    } on FirebaseAuthException catch (ex) {
      debugPrint("here error");
      emit(LoginErrorState(ex.message.toString()));
    }
  }

  void logout() async {
    await auth.signOut();
    emit(LoggedOutState());
  }
}

import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginOtpSentState extends LoginState {}

class LoginOtpVerificationState extends LoginState {}

class LoggedInState extends LoginState {
  final User userCredential;
   LoggedInState( this.userCredential);

}

class LoggedOutState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;
  LoginErrorState(this.error);
}

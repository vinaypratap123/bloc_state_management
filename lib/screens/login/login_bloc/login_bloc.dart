import 'package:bloc_state_management/screens/login/login_bloc/login_event.dart';
import 'package:bloc_state_management/screens/login/login_bloc/login_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(LoginErrorState("please enter the valid email"));
      } else if (event.passwordValue == "" || event.passwordValue.length < 8) {
        emit(LoginErrorState("please enter the valid password"));
      } else {
        emit(LoginValidateState());
      }
    });
    on<LoginSubmittedEvent>((event, emit) {
      emit(LoginLoadingState());
    });
  }
}

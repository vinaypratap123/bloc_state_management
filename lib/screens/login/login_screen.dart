import 'package:bloc_state_management/screens/home_screen.dart';
import 'package:bloc_state_management/screens/login/login_bloc/login_bloc.dart';
import 'package:bloc_state_management/screens/login/login_bloc/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginErrorState) {
                return Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: emailController,
            onChanged: (value) {
              BlocProvider.of<LoginBloc>(context).add(LoginTextChangedEvent(
                  emailController.text.toString(),
                  passwordController.text.toString()));
            },
            decoration: const InputDecoration(
                hintText: "Email address", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: passwordController,
            onChanged: (value) {
              BlocProvider.of<LoginBloc>(context).add(LoginTextChangedEvent(
                  emailController.text.toString(),
                  passwordController.text.toString()));
            },
            decoration: const InputDecoration(
                hintText: "Password", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SizedBox(
                width: 500,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (state is LoginValidateState) {
                      BlocProvider.of<LoginBloc>(context).add(
                          LoginSubmittedEvent(emailController.text.toString(),
                              passwordController.text.toString()));
                    }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (state is LoginValidateState)
                        ? Colors.blue
                        : Colors.grey,
                  ),
                  child: (state is LoginLoadingState)
                      ? const CircularProgressIndicator()
                      : const Text("Login"),
                ),
              );
            },
          )
        ],
      ),
    ));
  }
}

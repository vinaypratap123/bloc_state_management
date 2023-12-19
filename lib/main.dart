import 'package:bloc_state_management/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_state_management/screens/login/login_bloc/login_bloc.dart';
import 'package:bloc_state_management/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
     
      providers: [
         BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
         BlocProvider<InternetBloc>(create: (_) => InternetBloc()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: const LoginScreen()),
    );
  }
}

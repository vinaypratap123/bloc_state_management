import 'package:bloc_state_management/blocs/internet_bloc/internet_bloc.dart';
import 'package:bloc_state_management/firebase_options.dart';
import 'package:bloc_state_management/screens/login/login_bloc/login_bloc.dart';
import 'package:bloc_state_management/screens/login/phone_number_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
          home: const PhoneNumberScreen()),
    );
  }
}

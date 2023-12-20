import 'package:bloc_state_management/blocs/internet_bloc/internet_state.dart';
import 'package:bloc_state_management/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_state_management/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_state_management/screens/login/phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/internet_bloc/internet_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Internet Checking"),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Center(
              ///cubit

              // child: BlocConsumer<InternetCubit, InternetState>(
              //   listener: (context, state) {
              //     if (state == InternetState.lost) {
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //         content: Text("Internet Disconnected"),
              //         backgroundColor: Colors.red,
              //       ));
              //     } else if (state == InternetState.back) {
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //         content: Text("Internet Connected"),
              //         backgroundColor: Colors.green,
              //       ));
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state == InternetState.lost) {
              //       return const Text("disconnected");
              //     } else if (state == InternetState.back) {
              //       return const Text("connected");
              //     } else {
              //       return const Text("Loading...");
              //     }
              //   },
              // ),

              /// bloc consumer

              // child: BlocConsumer<InternetBloc, InternetState>(
              //   listener: (context, state) {
              //     if (state is InternetLostState) {
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //         content: Text("Internet Disconnected"),
              //         backgroundColor: Colors.red,
              //       ));
              //     } else if (state is InternetBackState) {
              //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //         content: Text("Internet Connected"),
              //         backgroundColor: Colors.green,
              //       ));
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is InternetLostState) {
              //       return const Text("disconnected");
              //     } else if (state is InternetBackState) {
              //       return const Text("connected");
              //     } else {
              //       return const Text("Loading...");
              //     }
              //   },
              // ),

              /// bloc builder

              // child: BlocBuilder<InternetBloc, InternetState>(
              //     builder: (context, state) {
              //   if (state is InternetLostState) {
              //     return const Text("disconnected");
              //   } else if (state is InternetBackState) {
              //     return const Text("connected");
              //   } else {
              //     return const Text("Loading...");
              //   }
              // }),

              /// bloc listener
              child: BlocListener<InternetBloc, InternetState>(
                listener: (context, state) {
                  if (state is InternetLostState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Internet Disconnected"),
                      backgroundColor: Colors.red,
                    ));
                  } else if (state is InternetBackState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Internet Connected"),
                      backgroundColor: Colors.green,
                    ));
                  }
                },
                child: const Text("Bloc Listener"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoggedOutState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PhoneNumberScreen()));
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginCubit>(context).logout();
                      },
                      child: const Text("Logout")),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bloc_state_management/blocs/internet_bloc/internet_state.dart';
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
      
        child: Center(
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

          child: BlocConsumer<InternetBloc, InternetState>(
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
            builder: (context, state) {
              if (state is InternetLostState) {
                return const Text("disconnected");
              } else if (state is InternetBackState) {
                return const Text("connected");
              } else {
                return const Text("Loading...");
              }
            },
          ),

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
          // child: BlocListener<InternetBloc, InternetState>(
          // listener: (context, state) {
          //     if (state is InternetLostState) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(
          //             content: Text("Internet Disconnected"),
          //             backgroundColor: Colors.red,
          //             ));
          //     } else if (state is InternetBackState) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //           const SnackBar(
          //             content: Text("Internet Connected"),
          //             backgroundColor: Colors.green,
          //             ));
          //     }
          //   },
          //   child: const Text("Bloc Listener"),
          // ),
        ),
      ),
    );
  }
}

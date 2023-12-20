import 'package:bloc_state_management/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_state_management/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_state_management/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: otpController,
                maxLength: 6,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter 6 digit otp",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoggedInState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  } else if (state is LoginErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                      duration: const Duration(milliseconds: 1000),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return SizedBox(
                    width: 400,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginCubit>(context)
                            .verifyOtp(otpController.text);
                      },
                      child: const Text("Verify OTP"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

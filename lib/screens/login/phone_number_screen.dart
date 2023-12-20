import 'package:bloc_state_management/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_state_management/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_state_management/screens/login/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController phoneController = TextEditingController();
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
                controller: phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Phone Number",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginOtpSentState) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtpScreen()));
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
                        String phoneNumber = "+91${phoneController.text}";
                        BlocProvider.of<LoginCubit>(context)
                            .sendOtp(phoneNumber);
                      },
                      child: const Text("Get OTP"),
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

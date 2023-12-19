import 'package:bloc_state_management/screens/login/otp_screen.dart';
import 'package:flutter/material.dart';

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
              SizedBox(
                width: 400,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // if (state is LoginValidateState) {
                    //   BlocProvider.of<LoginBloc>(context).add(
                    //       LoginSubmittedEvent(emailController.text.toString(),
                    //           passwordController.text.toString()));
                    // }
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OtpScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: (state is LoginValidateState)
                      //     ? Colors.blue
                      //     : Colors.grey,
                      ),
                  // child: (state is LoginLoadingState)
                  //     ? const CircularProgressIndicator()
                  //     : const Text("Get OTP"),
                  child: const Text("Get OTP"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

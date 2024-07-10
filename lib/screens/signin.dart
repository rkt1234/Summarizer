import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarizer_app/provider/signin_provider.dart';
import 'package:summarizer_app/screens/home.dart';
import 'package:summarizer_app/services/firebase_services.dart';
import 'package:summarizer_app/widgets/custom_container_widget.dart';
import 'package:summarizer_app/widgets/custom_text_widget.dart';
import 'package:summarizer_app/utils/alltextstyles.dart';
import 'package:summarizer_app/widgets/custom_textfield_widget.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SigninProvider>(
      builder: (context, signinProvider, child) {
        return Scaffold(
      backgroundColor: Color.fromARGB(255, 86, 166, 167),
      body: Stack(
        children: [
          Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(
                text: "Welcome", style: AllTextStyle().loginSignupPageTextStyle),
            const SizedBox(
              height: 20,
            ),
            CustomTextWidget(
                text: "Log into your account",
                style: AllTextStyle()
                    .loginSignupPageTextStyle
                    .copyWith(fontSize: 15)),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: CustomContainerWidget(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  height: 300,
                  width: 300,
                  borderRadius: 20,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        controller: emailController,
                        hintText: "E-mail",
                        hintStyle: AllTextStyle().hintStyleTextStyle,
                        style: AllTextStyle().textFieldTextStyle,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: "Password",
                        hintStyle: AllTextStyle().hintStyleTextStyle,
                        style: AllTextStyle().textFieldTextStyle,
                        icon: const Icon(
                          Icons.key,
                          color: Colors.grey,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          signinProvider.toggleLoading();
                                signinProvider.checkIfValid(emailController.text, passwordController.text);
                                signinProvider.isValid? signinProvider.snackbarMessage=await FirebaseServices().signinUser(emailController.text, passwordController.text):null;
                                signinProvider.toggleLoading();
                                if (signinProvider.snackbarMessage ==
                                        "User signed in") {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      );
                                    }
                                !signinProvider.isLoading?ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                  duration: Duration(milliseconds: 500),
                                        content: Center(
                                            child: Text(
                                          signinProvider.snackbarMessage,
                                          style: TextStyle(color: signinProvider.snackbarMessage=="User registered"? Colors.white:Colors.red
                                                
                                          ),
                                        )),
                                        backgroundColor:
                                            Color.fromARGB(255, 86, 166, 167),
                                      )):null;
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                                255, 255, 122, 123) // Background color
                            ),
                        child: const Text("Signin"),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextWidget(
                    text: "New user ? ",
                    style: AllTextStyle()
                        .loginSignupPageTextStyle
                        .copyWith(fontSize: 15)),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: CustomTextWidget(
                      text: "Sign up",
                      style: AllTextStyle()
                          .loginSignupPageTextStyle
                          .copyWith(fontSize: 15, color: Colors.brown)),
                )
              ],
            )
          ],
        ),
      ),
      signinProvider.isLoading? const Center(
                        child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 122, 123)
                      ))
                    : Container()
        ],
      )
    );
      },
    );
  }
}

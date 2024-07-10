import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarizer_app/provider/signup_provider.dart';
import 'package:summarizer_app/screens/home.dart';
import 'package:summarizer_app/screens/signin.dart';
import 'package:summarizer_app/services/firebase_services.dart';
import 'package:summarizer_app/widgets/custom_container_widget.dart';
import 'package:summarizer_app/widgets/custom_text_widget.dart';
import 'package:summarizer_app/utils/alltextstyles.dart';
import 'package:summarizer_app/widgets/custom_textfield_widget.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    emailController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupProvider>(builder: (context, signupProviders, child) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 86, 166, 167),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                      text: "Register",
                      style: AllTextStyle().loginSignupPageTextStyle),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextWidget(
                      text: "Create a new account",
                      style: AllTextStyle()
                          .loginSignupPageTextStyle
                          .copyWith(fontSize: 15)),
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: CustomContainerWidget(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 50),
                        height: 350,
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
                            CustomTextField(
                              controller: confirmPasswordController,
                              hintText: "Confirm Password",
                              hintStyle: AllTextStyle().hintStyleTextStyle,
                              style: AllTextStyle().textFieldTextStyle,
                              icon: const Icon(
                                Icons.key,
                                color: Colors.grey,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                signupProviders.toggleLoading();
                                signupProviders.checkIfValid(
                                    emailController.text,
                                    passwordController.text,
                                    confirmPasswordController.text);
                                signupProviders.isValid
                                    ? signupProviders.snackbarMessage =
                                        await FirebaseServices().registerUser(
                                            emailController.text,
                                            passwordController.text)
                                    : null;
                                signupProviders.toggleLoading();
                                if(signupProviders.snackbarMessage=="User registered")
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                  );
                                }
                                !signupProviders.isLoading
                                    ? ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Center(
                                            child: Text(
                                          signupProviders.snackbarMessage,
                                          style: TextStyle(
                                              color: signupProviders
                                                          .snackbarMessage ==
                                                      "User registered"
                                                  ? Colors.white
                                                  : Colors.red),
                                        )),
                                        backgroundColor:
                                            Color.fromARGB(255, 86, 166, 167),
                                      ))
                                    : null;
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                      255, 255, 122, 123) // Background color
                                  ),
                              child: const Text("Signup"),
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
                          text: "Already have an account ? ",
                          style: AllTextStyle()
                              .loginSignupPageTextStyle
                              .copyWith(fontSize: 15)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signin()),
                          );
                        },
                        child: CustomTextWidget(
                            text: "Sign in",
                            style: AllTextStyle()
                                .loginSignupPageTextStyle
                                .copyWith(fontSize: 15, color: Colors.brown)),
                      )
                    ],
                  )
                ],
              ),
            ),
            signupProviders.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 122, 123)))
                : Container()
          ],
        ),
      );
    });
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:summarizer_app/screens/history.dart';
import 'package:summarizer_app/screens/input.dart';
import 'package:summarizer_app/screens/signup.dart';
import 'package:summarizer_app/services/firebase_services.dart';
import 'package:summarizer_app/utils/alltextstyles.dart';
import 'package:summarizer_app/widgets/custom_container_widget.dart';
import 'package:summarizer_app/widgets/custom_text_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 79, 158, 160),
                  height: 300,
                  width: double.infinity,
                ),
              ],
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CustomContainerWidget(
                    borderRadius: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 80,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 255, 122, 123),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 0,
                        ),
                        CustomTextWidget(
                            text: "Sanshipt",
                            style: AllTextStyle().titleTextStyle),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Signup()));
                              FirebaseServices().logoutUser();
                            },
                            child: const Icon(
                              Icons.logout,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2.0,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    height: 400,
                    width: 300,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWidget(
                              text: "Summarizer",
                              style: AllTextStyle().summarizerTextStyle),
                          CustomTextWidget(
                              text: "Choose what you want to summarize",
                              style: AllTextStyle().choiceMessageTextStyle),
                          Row(
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Input(
                                                  inputType: "TEXT",
                                                )),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit_document,
                                      size: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                                  CustomTextWidget(
                                      text: "Raw Text",
                                      style: AllTextStyle().choiceTextStyle)
                                ],
                              ),
                              const Spacer(),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Input(
                                                  inputType: "URL",
                                                )),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.link,
                                      size: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                                  CustomTextWidget(
                                      text: "Article",
                                      style: AllTextStyle().choiceTextStyle)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (kDebugMode) {
                        print("isme aya h");
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const History()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromARGB(255, 86, 166, 167),
                      ),
                      child: Center(
                          child: CustomTextWidget(
                              text: "View saved summaries",
                              style: AllTextStyle().choiceMessageTextStyle)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

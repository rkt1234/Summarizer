import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:summarizer_app/provider/summary_provider.dart';
import 'package:summarizer_app/services/firebase_services.dart';
import 'package:summarizer_app/utils/alltextstyles.dart';
import 'package:summarizer_app/widgets/custom_text_widget.dart';

class Summaryy extends StatefulWidget {
  const Summaryy({super.key});

  @override
  State<Summaryy> createState() => _SummaryyState();
}

class _SummaryyState extends State<Summaryy> {
  late String title;
  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryProvider>(
      builder: (context, summaryProvider, child) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: summaryProvider.isLoading
                ? Container(
                    color: Colors.white,
                    child: const Center(child: CircularProgressIndicator()))
                : Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            color: const Color.fromARGB(255, 79, 158, 160),
                            height: 300,
                            width: double.infinity,
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              width: double.infinity,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: double.infinity,
                              color: const Color.fromARGB(255, 255, 122, 123),
                              child: Center(
                                  child: CustomTextWidget(
                                      text: "Summary",
                                      style: AllTextStyle().titleTextStyle)),
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              child: SelectableText(summaryProvider.summary,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300)),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 80),
                                height: 50,
                                width: double.infinity,
                                child: !summaryProvider.showSave
                                    ? null
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255,
                                              86,
                                              166,
                                              167), // Background color
                                        ),
                                        onPressed: () async {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                true, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 79, 158, 160),
                                                title: const Text(
                                                  'Enter a title',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                content: TextField(
                                                  onChanged: (value) {
                                                    title = value;
                                                  },
                                                ),
                                                actions: [
                                                  TextButton(
                                                    child: const Text(
                                                      'OK',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                    ),
                                                    onPressed: () async{
                                                      Navigator.pop(context);
                                                      print("call hua h ");
                                                      String snackbarMessage=await FirebaseServices().saveSummary(summaryProvider.summary,title);
                                                      var snackBar =
                                                           SnackBar(
                                                        duration:const Duration(
                                                            milliseconds: 200),
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                79, 158, 160),
                                                        content: Center(
                                                            child: Text(
                                                                snackbarMessage)),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 80),
                                height: 50,
                                width: double.infinity,
                                child: !summaryProvider.showSave
                                    ? null
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255,
                                              86,
                                              166,
                                              167), // Background color
                                        ),
                                        onPressed: () {
                                          Clipboard.setData(
                                              ClipboardData(text: summaryProvider.summary));
                                        },
                                        child: const Text(
                                          'Copy summary',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )),
                          ],
                        ),
                      ),
                    ],
                  ));
      },
    );
  }
}

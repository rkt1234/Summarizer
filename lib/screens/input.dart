import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summarizer_app/provider/summary_provider.dart';
import 'package:summarizer_app/screens/summary.dart';
import 'package:summarizer_app/services/api_service.dart';
import 'package:summarizer_app/utils/alltextstyles.dart';
import 'package:summarizer_app/widgets/custom_text_widget.dart';

class Input extends StatefulWidget {
  late String inputType;
  Input({super.key, required this.inputType});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  String inputText="";
  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryProvider>(
      builder: (context, summaryProvider, child) {
        return Scaffold(
          body: Stack(children: [
            Column(
              children: [
                Container(
                  color: const Color.fromARGB(255, 79, 158, 160),
                  height: 500,
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
              child: Column(children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  color: const Color.fromARGB(255, 255, 122, 123),
                  child: Center(
                      child: CustomTextWidget(
                          text: "Sanshipt",
                          style: AllTextStyle().titleTextStyle)),
                ),
                const SizedBox(
                  height: 50,
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
                  height: 500,
                  width: 300,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 50),
                      child: TextField(
                        onChanged: (value) {
                          inputText=value;
                        },
                        style: const TextStyle(color: Colors.black),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "Enter your ${widget.inputType} here"),
                      )),
                ),
                const SizedBox(
                  height: 70,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 86, 166, 167), // Background color
                      ),
                      onPressed: () async{
                        if(inputText!='')
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Summaryy()),
                          );
                          summaryProvider.toggleLoading();
                          summaryProvider.summary = await APIService()
                              .getSummary(inputText, widget.inputType);
                          summaryProvider.toggleLoading();
                          summaryProvider.show();
                        }
                        else if(inputText=='')
                        {
                          var snackBar = const SnackBar(
                            duration: const Duration(milliseconds: 500),
                            backgroundColor: Color.fromARGB(255, 79, 158, 160),
                            content: Center(child: Text("Cannot summarise empty text")),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: CustomTextWidget(
                          text: "Summarize",
                          style: const TextStyle().copyWith(color: Colors.white))),
                )
              ]),
            ),
          ]),
        );
      },
    );
  }
}
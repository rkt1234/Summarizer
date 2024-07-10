import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Show extends StatefulWidget {
  late String summary;
  Show({super.key, required this.summary});

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 79, 158, 160),
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
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    color: const Color.fromARGB(255, 255, 122, 123),
                    child: const Center(
                      child: Text(
                        'Sanshipt',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800)
                      ),
                    ),
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
                      padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                      child: SelectableText(
                        widget.summary,
                        style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w200),
                        ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
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
                        onPressed: () {
                          var snackBar = const SnackBar(
                            duration: Duration(milliseconds: 200),
                            backgroundColor: Color.fromARGB(255, 79, 158, 160),
                            content: Center(child: Text('Text copied')),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Clipboard.setData(
                              ClipboardData(text: widget.summary));
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
            )
          ],
        ),
      );
  }
}
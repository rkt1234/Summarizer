import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarizer_app/screens/show.dart';
import 'package:summarizer_app/services/firebase_services.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('posts');
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 86, 166, 167),
        appBar: AppBar(
          elevation: 0,
          title: const Center(
            child: Text(
              'Saved Summaries',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          height: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: ref.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting) {
                return !(!snapshot.hasData || snapshot.data!.docs.isEmpty)
                    ? ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          return snapshot.data!.docs[index]['userId']==
                                  user?.uid
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Show(
                                                summary: snapshot.data!
                                                    .docs[index]['summary'],
                                              )),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 80,
                                    child: Card(
                                      elevation: 3,
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    ['title'],
                                              )),
                                          const Spacer(),
                                          IconButton(
                                            onPressed: () async {
                                              FirebaseServices().deleteSummary(
                                                  snapshot
                                                      .data!.docs[index].id);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.blueGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              : null;
                        })
                    : const Center(
                        child: Text("No summaries saved!!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
            },
          ),
        ));
  }
}

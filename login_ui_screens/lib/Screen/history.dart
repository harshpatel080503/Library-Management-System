import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:login_ui_screens/Screen/return.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List mybook = [];
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    final snapshot = await _firestore
        .collection('user')
        .doc(Hive.box("app").get("docid"))
        .collection("history")
        .get();
    // mybook = snapshot.data()!["book"];
    setState(() {
      mybook = snapshot.docs.map((doc) => doc.data()).toList();

      print(mybook);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.8,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: mybook.length,
                itemBuilder: (BuildContext context, int index) {
                  bool check = mybook[index]["returen"] ?? false;
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contex) => returnbook(
                                    docid: mybook[index]["docid"],
                                    check: check,
                                  )));
                    },
                    leading: Image.network(
                        errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.book);
                    }, mybook[index]["img"]),
                    title: Text(mybook[index]["title"].toString()),
                    subtitle: Text(mybook[index]["author"].toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

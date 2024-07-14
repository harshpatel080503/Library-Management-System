// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:login_ui_screens/Provider/data.dart';

class returnbook extends StatefulWidget {
  final String docid;
  bool check;
  returnbook({super.key, required this.docid, required this.check});

  @override
  State<returnbook> createState() => _returnbookState();
}

class _returnbookState extends State<returnbook> {
  List arry = books["books"];
  String img = "";
  String title = "";
  String isbn = "";
  String author = "";
  String publisher = "";
  String year = "";
  String genre = "";
  String quantity = "";
  String description = "";
  final _firestore = FirebaseFirestore.instance;

  Map<String, dynamic>? result = {};
  @override
  void initState() {
    super.initState();
    fetch();
    // final snapshot =
    //     await _firestore.collection('book').doc(widget.docid).get();
    // result = snapshot.data();
    // setState(() {});
  }

  Future<void> fetch() async {
    // print(widget.docid);
    final snapshot =
        await _firestore.collection('book').doc(widget.docid).get();
    // var data = snapshot.data;
    // print(snapshot.exists);
    // Map<String, dynamic>? result = snapshot.data();
    result = snapshot.data();
    // print(result);
    setState(() {});
    print(widget.docid);
    img = result?["ImageUrl"];
    title = result?["Title"];
    isbn = result?["ISBN"];
    author = result?["Author"];
    publisher = result?["Publisher"];
    year = result!["Year"].toString();
    genre = result?["Genre"];
    quantity = result!["qunatity"].toString() ?? "0";
    description = result?["Description"];
    setState(() {});
    // print(result?["Publisher"]);
    // setState(() {
    // popular = snapshot.docs.map((doc) => doc.data()).toList();
    // _users = _data;
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width() {
      if (size.width > 600) {
        return 600;
      }
      return size.width;
    }

    bool mobile() {
      if (size.width > 600) {
        return false;
      }
      return true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: mobile()
          ? mobileview(context)
          : SingleChildScrollView(
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height,
                    child: Column(
                      children: [
                        const Gap(10),
                        Image.network(
                          img ??
                              "https://covers.openlibrary.org/b/isbn/9781503290563-L.jpg",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: size.width * 0.5,
                      height: size.height,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gap(size.height * 0.08),
                            ListTile(
                              title: const Text("ISBN :"),
                              subtitle: Text(result?["ISBN"]),
                            ),
                            ListTile(
                              title: const Text("Author"),
                              subtitle: Text(author),
                            ),
                            ListTile(
                              title: const Text("Publisher"),
                              subtitle: Text(publisher),
                            ),
                            ListTile(
                              title: const Text("Year"),
                              subtitle: Text(year),
                            ),
                            ListTile(
                              title: const Text("Genre"),
                              subtitle: Text(genre),
                            ),
                            ListTile(
                              title: const Text("Quantity"),
                              subtitle: Text(quantity),
                            ),
                            ListTile(
                              title: const Text("Description"),
                              subtitle: Text(description),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final firestore = FirebaseFirestore.instance;
          final email = FirebaseAuth.instance.currentUser?.email;
          // DateTime now = DateTime.now();
          // DateTime deadline = now.add(const Duration(days: 15));
          // print(now);
          // print(deadline);
          // firestore.collection("book").doc(widget.docid).update({
          //   "qunatity": int.parse(quantity) - 1,
          //   "owner": email.toString(),
          //   "status": "unaviable",
          //   "barrow_time":  DateTime.now()
          //   // "deadline":
          // });

          // void showAlertDialog(BuildContext context) {
          // Set up the button
          // if (int.parse(quantity) != 0) {
          AlertDialog alert = AlertDialog(
            title: const Text("Return book"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    img ??
                        "https://m.media-amazon.com/images/I/71CQFGiPA+L.SL1360.jpg",
                    height: 150,
                  ),
                  const Gap(20),
                  Text("Title : $title"),
                  Text("Author : $author"),
                  Text("ISBN : $isbn"),
                  // Text("Barrow time : $now"),
                  // Text("Deadline : $deadline"),

                  // const Text("This is a simple alert dialog."),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    firestore.collection("book").doc(widget.docid).update({
                      "qunatity": int.parse(quantity) + 1,
                      "owner": "",
                      "status": "avaible",
                      "barrow_time": "",
                      "deadline": ""
                    });
                    // firestore
                    //     .collection("user")
                    //     .doc(Hive.box("app").get("docid"))
                    //     .collection("history")
                    //     .add({
                    //   "title": title,
                    //   "docid": widget.docid,
                    //   "author": author,
                    //   "isbn": isbn,
                    //   "barrow_time": "",
                    //   "deadline": "",
                    //   "img": img
                    // });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("return sussefully taken"),
                      ),
                    );
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text("return")),
            ],
          );

          // Show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text("not avaible"),
          //     ),
          //   );
          // }

          // Set up the AlertDialog

// }
        },
        label: widget.check ? const Text("Return book") : const Text("Return"),
      ),
    );
  }

  Widget mobileview(context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: size.height,
          width: size.width * 0.9,
          child: ListView(
            children: [
              Image.network(
                height: size.height * 0.4,
                img,
              ),
              ListTile(
                title: const Text("ISBN :"),
                subtitle: Text(isbn),
              ),
              ListTile(
                title: const Text("Author"),
                subtitle: Text(author),
              ),
              ListTile(
                title: const Text("Publisher"),
                subtitle: Text(publisher),
              ),
              ListTile(
                title: const Text("Year"),
                subtitle: Text(year),
              ),
              ListTile(
                title: const Text("Genre"),
                subtitle: Text(genre),
              ),
              ListTile(
                title: const Text("Quantity"),
                subtitle: Text(quantity),
              ),
              ListTile(
                title: const Text("Description"),
                subtitle: Text(description),
              )
            ],
          ),
        ),
      ),
    );
  }
}

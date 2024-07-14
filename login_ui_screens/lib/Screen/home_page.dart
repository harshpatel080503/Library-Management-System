import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login_ui_screens/Provider/data.dart';
import 'package:login_ui_screens/Provider/gemini.dart';
import 'package:login_ui_screens/Screen/bookdetail.dart';
import 'package:login_ui_screens/Screen/history.dart';
import 'package:login_ui_screens/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List arry = books["books"];
  final _firestore = FirebaseFirestore.instance;
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> popular = [];
  List<Map<String, dynamic>> _data = [];
  List<Map<String, dynamic>> newarrivals = [];

  List pop = [];
  List na = [];

  @override
  void initState() {
    List data = books["books"];
    super.initState();
    _getUsers();
    _searchController.addListener(() {
      setState(() {});
    });
    // for (var i = 0; i < 10; i++) {
    //   pop.add(data[i]);
    // }
    // for (var i = 11; i < 20; i++) {
    //   pop.add(data[i]);
    // }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _getUsers() async {
    final snapshot = await _firestore.collection('book').get();
    setState(() {
      _data = snapshot.docs.map((doc) => doc.data()).toList();
    });
    for (var i = 0; i < 10; i++) {
      popular.add(_data[i]);
    }
    for (var i = 10; i < 20; i++) {
      newarrivals.add(_data[i]);
    }
    // final snapshot1 = await _firestore.collection('pop').get();
    // setState(() {
    // _users = _data;
    // });
    // final snapshot2 = await _firestore.collection('new').get();
    // setState(() {
    //   newarrivals = snapshot2.docs.map((doc) => doc.data()).toList();
    //   // _users = _data;
    // });
    // print(popular.length);
    // print(newarrivals.length);
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
      backgroundColor: backgroundColor1,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor1,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.logout))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => History()));
            },
            icon: const Icon(Icons.book_rounded)),
        // centerTitle: true,
        // title: const Text("Home"),
      ),
      body: mobile()
          ? phone(context)
          : SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(
                          // controller: value.phone,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Search books here",
                            contentPadding: const EdgeInsets.only(
                                left: 20, top: 20, bottom: 20),
                            hintStyle: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                            prefixIcon: const Icon(Icons.search_rounded),
                            // prefixText: "+91",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        Gap(size.height * 0.05),
                        Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.7,
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "New Arrivals",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(20, 25, 122, 0.8),
                                        ),
                                      )
                                    ],
                                  ),
                                  Gap(size.height * 0.05),
                                  SizedBox(
                                    height: size.height * 0.55,
                                    width: width(),
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: newarrivals.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Book_deatils(
                                                            docid: newarrivals[
                                                                    index]
                                                                ["docid"])));
                                          },
                                          leading: Image.network(errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.book);
                                          }, newarrivals[index]["ImageUrl"]),
                                          // title: Text(popular[index]["title"]),
                                          title:
                                              Text(newarrivals[index]["Title"]),
                                          subtitle: Text(
                                              newarrivals[index]["Author"]),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.7,
                              child: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "Popular books",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromRGBO(20, 25, 122, 0.8),
                                        ),
                                      )
                                    ],
                                  ),
                                  Gap(size.height * 0.05),
                                  SizedBox(
                                    height: size.height * 0.55,
                                    width: width(),
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: popular.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Book_deatils(
                                                            docid: popular[
                                                                    index]
                                                                ["docid"])));
                                          },
                                          leading: Image.network(errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(Icons.book);
                                          }, popular[index]["ImageUrl"]),
                                          title: Text(popular[index]["Title"]),
                                          subtitle:
                                              Text(popular[index]["Author"]),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      // drawer: const Drawer(
      //   child: Column(
      //     children: [
      //       DrawerHeader(
      //           child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Text(
      //             "Libary App",
      //             style: TextStyle(fontWeight: FontWeight.w700),
      //             textScaler: TextScaler.linear(1.8),
      //           ),
      //           ListTile(
      //             //  navigation /////////////////////////////////////////////////////////////////////////////////////
      //             leading: Icon(Icons.person),
      //             title: Text(
      //               "My book",
      //               style: TextStyle(fontWeight: FontWeight.w600),
      //               textScaler: TextScaler.linear(1),
      //             ),
      //           ),
      //         ],
      //       )),
      //     ],
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseAuth.instance.signOut(); // Gem().book();
          List bdata = books[
              "books"]; //////////////////////////////////////////////////////
          // print(books[0]["isbn13"]);
          // print("start");
          // final firestore = FirebaseFirestore.instance;
          // for (int i = 6; i < 11; i++) {
          /////////////////////////////////////////////////
          //   print("done $i");
          //   final firestore = FirebaseFirestore.instance;
          //   CollectionReference user = firestore.collection("pop");
          //   DocumentReference ref = await user.add({
          //     "Title": bdata[i]["Title"],
          //     "ISBN": bdata[i]["ISBN"],
          //     "Author": bdata[i]["Author"],
          //     "Publisher": bdata[i]["Publisher"],
          //     "Year": bdata[i]["Year"],
          //     "Description": bdata[i]["Description"],
          //     "Genre": bdata[i]["Genre"].toString(),
          //     "ImageUrl": bdata[i]["ImageUrl"],

          //     // "isbn13": bdata[i]["isbn13"],
          //     // "isbn10": bdata[i]["isbn10"],
          //     // "title": bdata[i]["title"],
          //     // "catagory": bdata[i]["categories"],
          //     // "authors": bdata[i]["authors"],
          //     // "published_year": bdata[i]["published_year"],
          //     // "average_rating": bdata[i]["average_rating"],
          //     // "description": bdata[i]["description"],
          //     // "thumbnail": bdata[i]["thumbnail"],
          //     "qunatity": 1,
          //     "time": DateTime.now(),
          //     "owner": "",
          //     "deadline": "",
          //     "status": "available"
          //   });
          //   user.doc(ref.id).update({"docid": ref.id});
          // } /////////////////////////////////////////////////////

          // print("end..");
          // });
          // CollectionReference user = firestore
          //     .collection("books")
          //     .doc("allbooks")
          //     .collection(books[i]["isbn13"]);
          // DocumentReference ref = await user.add(books[i]);

          // print("end.....");
          // }
          // Gem().gemini_prompt();
        },
        child: const Text("click"),
      ),
    );
  }

  Widget phone(context) {
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

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          height: size.height,
          width: width(),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                TextField(
                  // controller: value.phone,
                  style: const TextStyle(
                      fontFamily: "Poppins", fontWeight: FontWeight.w600),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: "Search books here",
                    contentPadding:
                        const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                    hintStyle: const TextStyle(
                        fontFamily: "Poppins", fontWeight: FontWeight.w700),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                    prefixIcon: const Icon(Icons.search_rounded),
                    // prefixText: "+91",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
                Gap(size.height * 0.05),
                const Row(
                  children: [
                    Text(
                      "New Arrivals",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(20, 25, 122, 0.8),
                      ),
                    )
                  ],
                ),
                Gap(size.height * 0.05),
                SizedBox(
                  height: size.height * 0.6,
                  width: width(),
                  child: ListView.builder(
                    scrollDirection: mobile() ? Axis.vertical : Axis.vertical,
                    itemCount: newarrivals.length,
                    itemBuilder: (BuildContext context, int index) {
                      return mobile()
                          ? Card(
                              child: SizedBox(
                                width: size.width * 0.3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (contex) =>
                                                    Book_deatils(
                                                        docid:
                                                            newarrivals[index]
                                                                ["docid"])));
                                      },
                                      minTileHeight: size.height * 0.15,
                                      leading: Image.network(
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.book);
                                        },
                                        newarrivals[index]["ImageUrl"],
                                        height: size.height * 0.1,
                                      ),
                                      title: Text(
                                          overflow: TextOverflow.ellipsis,
                                          newarrivals[index]["Title"] ??
                                              "loading"),
                                      subtitle: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "Author : ${newarrivals[index]["Author"] ?? ""}"),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : ListTile(
                              leading: Image(
                                image: const AssetImage("assets/bg.png"),
                                height: size.height * 0.12,
                              ),
                              title: const Text("title"),
                              subtitle: const Text("author"),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

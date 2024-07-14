// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:login_ui_screens/Provider/api_provider.dart';
import 'package:login_ui_screens/Provider/data.dart';

class Gem {
  bool loading = false;
  Future<void> gemini_prompt() async {
    final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: ApiDetails().gemini_api,
        generationConfig:
            GenerationConfig(responseMimeType: "application/json"));

    const prompt =
        'write a random idea give for study me json output {idea:ans, desp:desp, heading:heading} in 100 words';
    final content = [Content.text(prompt)];
    loading = true;
    final response = await model.generateContent(content);
    Map<String, dynamic> jsonop = jsonDecode(response.text!);
    print(jsonop);
    // print(response.text);
    loading = false;
  }

  Future<void> book() async {
    final firestore = FirebaseFirestore.instance;
    // for (var i = 0; i < books["books"]; i++) {}
    List arry = books["books"];
    print(arry[0]);
    // CollectionReference book =
    // firestore.collection("books").doc("allbooks").collection('');
    // DocumentReference ref = await book.add({});
    // user.doc(ref.id).update({"docid": ref.id});
  }
}


// Center(
//         child: 
//         TextButton(
//             onPressed: () {
//               FirebaseAuth.instance.signOut();
//             },
//             child: const Text("logout")),
//       ),

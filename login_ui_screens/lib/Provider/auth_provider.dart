// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:login_ui_screens/Screen/gate.dart';
import 'package:login_ui_screens/admin/admin.dart';

class AuthernicationProvider extends ChangeNotifier {
  bool pass = false;
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController admin_email = TextEditingController();
  TextEditingController admin_pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool pass2 = false;
  TextEditingController email_id = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> user_data(String email, String password, context) async {
    final firestore = FirebaseFirestore.instance;
    CollectionReference user = firestore.collection("user");
    DocumentReference ref = await user.add({
      "email": email,
      "password": password,
      "time": DateTime.now(),
      "phone": phone.text.trim()
    });
    user.doc(ref.id).update({"docid": ref.id});
    Hive.box("app").put("docid", ref.id);
  }

  signin_admin(context) async {
    if (admin_email.text.isNotEmpty && admin_pass.text.isNotEmpty) {
      try {
        final data = await firestore.collection("admin").doc("admin").get();
        Map<String, dynamic> admin = data.data() as Map<String, dynamic>;
        if (admin_email.text == admin["email"] &&
            admin_pass.text == admin["password"]) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AdminPage()),
              (route) => false);
          showSnackbar(context, "sussessfully logged in as admin");
        } else {
          showSnackbar(context, "Wrong Credentials !");
        }
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.message!);
      }
    } else {
      showSnackbar(context, "Enter Valid Input's");
    }
  }

  signin(String email, String pass, context) async {
    if (email.isNotEmpty && pass.isNotEmpty) {
      try {
        await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: pass)
            .then((value) => showSnackbar(context, "Sign In Done"));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context1) => const Gate()),
            (route) => false);
        await firestore
            .collection("users")
            .doc(firebaseAuth.currentUser?.uid)
            .set({
          "uuid": firebaseAuth.currentUser?.uid,
          "email": email,
          "password": pass
        });
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.message!);
      }
    } else {
      showSnackbar(context, "Enter Valid Input's");
    }
  }

  createaccount(
      String email, String pass1, String pass2, String phone, context) async {
    if (email.isNotEmpty &&
        pass1.isNotEmpty &&
        pass2.isNotEmpty &&
        phone.isNotEmpty) {
      try {
        if (pass1 == pass2) {
          await firebaseAuth
              .createUserWithEmailAndPassword(email: email, password: pass1)
              .then((value) => showSnackbar(context, "created"));
          await user_data(email, pass1, context);
          // signin(email, pass1, context);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context1) => const Gate()),
              (route) => false);
        } else {
          showSnackbar(context, "Check your passwords again");
        }
      } on FirebaseAuthException catch (e) {
        showSnackbar(context, e.message!);
      }
    } else {}
  }
}

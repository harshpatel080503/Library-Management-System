import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_screens/Provider/auth_provider.dart';
import 'package:login_ui_screens/Screen/authpage.dart';
import 'package:login_ui_screens/Screen/home_page.dart';
import 'package:provider/provider.dart';

class Gate extends StatefulWidget {
  const Gate({super.key});

  @override
  State<Gate> createState() => _GateState();
}

class _GateState extends State<Gate> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthernicationProvider>(builder: (context, value, child) {
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const AuthPage();
            }
          },
        ),
      );
    });
  }
}

// // class Auth {
// //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
// //   FirebaseFirestore firestore = FirebaseFirestore.instance;

// //   void showSnackbar(BuildContext context, String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //       ),
// //     );
// //   }

// //   signin(String email, String pass, context) async {
// //     if (email.isNotEmpty && pass.isNotEmpty) {
// //       try {
// //         await firebaseAuth
// //             .signInWithEmailAndPassword(email: email, password: pass)
// //             .then((value) => showSnackbar(context, "Sign In Done"));
// //         Navigator.pushAndRemoveUntil(
// //             context,
// //             MaterialPageRoute(builder: (context1) => const Gate()),
// //             (route) => false);
// //         await firestore
// //             .collection("users")
// //             .doc(firebaseAuth.currentUser?.uid)
// //             .set({
// //           "uuid": firebaseAuth.currentUser?.uid,
// //           "email": email,
// //           "password": pass
// //         });
// //       } on FirebaseAuthException catch (e) {
// //         showSnackbar(context, e.message!);
// //       }
// //     } else {
// //       showSnackbar(context, "Enter Valid Input's");
// //     }
// //   }

// //   createaccount(String email, String pass1, String pass2, context) async {
// //     if (email.isNotEmpty && pass1.isNotEmpty && pass2.isNotEmpty) {
// //       try {
// //         if (pass1 == pass2) {
// //           await firebaseAuth
// //               .createUserWithEmailAndPassword(email: email, password: pass1)
// //               .then((value) => showSnackbar(context, "created"));
// //           signin(email, pass1, context);
// //           Navigator.pushAndRemoveUntil(
// //               context,
// //               MaterialPageRoute(builder: (context1) => const Gate()),
// //               (route) => false);
// //         } else {
// //           showSnackbar(context, "Check your passwords again");
// //         }
// //       } on FirebaseAuthException catch (e) {
// //         showSnackbar(context, e.message!);
// //       }
// //     } else {}
// //   }
// // }
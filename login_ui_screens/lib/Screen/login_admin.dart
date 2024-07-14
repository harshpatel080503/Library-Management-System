import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:login_ui_screens/Provider/auth_provider.dart';
import 'package:login_ui_screens/main.dart';
import 'package:provider/provider.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AuthernicationProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor1,
        ),
        backgroundColor: backgroundColor1,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 20),
                            child: Text(
                              "Admin Portal",
                              textScaler: TextScaler.linear(2.4),
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w800,
                                color: Color.fromRGBO(20, 25, 122, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ///////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Text(
                              "Welcome Back, Admin.\nAccess Your Admin Dashboard",
                              textScaler: TextScaler.linear(2),
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(20, 25, 122, 0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextField(
                            controller: value.admin_email,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              hintText: "Admin Email",
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
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          Gap(size.height * 0.025),
                          TextField(
                            controller: value.admin_pass,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: value.pass2,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white70,
                              hintText: "Password",
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
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15)),
                              suffixIcon: IconButton(
                                icon: Icon(value.pass2
                                    ? Icons.visibility_off
                                    : Icons.visibility_rounded),
                                onPressed: () {
                                  setState(() {
                                    value.pass2 = !value.pass2;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      ///btn here

                      ///
                      SizedBox(
                        width: size.width * 0.85,
                        height: size.height * 0.08,
                        child: FilledButton(
                            onPressed: () async {
                              await value.signin_admin(context);
                            },
                            style: ButtonStyle(
                                backgroundColor: const WidgetStatePropertyAll(
                                    Color.fromRGBO(20, 25, 122, 0.8)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)))),
                            child: const Text(
                              "Access Admin Dashboard",
                              textScaler: TextScaler.linear(1.3),
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w700),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_ui_screens/Screen/gate.dart';
import 'package:login_ui_screens/admin/add.dart';
import 'package:login_ui_screens/admin/detail.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _firestore = FirebaseFirestore.instance;
  final _searchController = TextEditingController();
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
    _searchController.addListener(() {
      setState(() {});
    });
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
      _users = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () async {
              _getUsers();
            },
          ),
          Tooltip(
            message: "Logout",
            child: IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Gate()),
                    (route) => false);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        _data = _users;
                      });
                    },
                    icon: const Icon(Icons.close)),
                hintText: 'Search by Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Filter users based on search text
                setState(() {
                  if (value.isNotEmpty) {
                    _data = _users.where((user) {
                      return user["email"]
                          .toLowerCase()
                          .contains(value.toLowerCase());
                    }).toList();
                  } else {
                    _data = _users;
                  }
                });
              },
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                final user = _data[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Image.network(user["ImageUrl"].toString()),
                      title: Text(user["Title"].toString()),
                      subtitle: Text(user["Author"].toString()),
                      // onTap: () => Navigator.push(
                      //   context,
                      // MaterialPageRoute(
                      //   builder: (context) => UserDetailsPage(user: user),
                      // ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addbook()));
        },
        child: Text("Add"),
      ),
    );
  }
}

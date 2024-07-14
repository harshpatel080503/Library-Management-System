import 'package:flutter/material.dart'; // Import UserData

class UserDetailsPage extends StatelessWidget {
  final Map<String, dynamic> user;

  UserDetailsPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Email:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(user["email"]),
            const SizedBox(height: 16.0),
            const Text(
              'Password:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(user[
                "password"]), // **Security Note:** Consider hashing passwords before storing in the database and never displaying them in plain text.
            const SizedBox(height: 16.0),
            const Text(
              'Timestamp:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(user["time"].toString()),
            const SizedBox(height: 16.0),
            const Text(
              'Docid:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(user["docid"].toString()),
          ],
        ),
      ),
    );
  }
}

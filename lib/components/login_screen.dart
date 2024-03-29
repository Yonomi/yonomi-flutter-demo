import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = TextEditingController();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please Enter User Id'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: loginController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (loginController.text != '') {
            String trimmedText = loginController.text.trim();
            Navigator.pushNamed(
              context,
              'app',
              arguments: trimmedText,
            );
          }
        },
        tooltip: 'Login',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}

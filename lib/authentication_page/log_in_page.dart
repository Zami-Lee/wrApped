import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app2/authentication_page/sign_up_page.dart';
import 'package:food_app2/main.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'login failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome back!', style: TextStyle(color: appBarTextColour, fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: appBarColour,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("log in to your account :)", style: TextStyle(color: mainTextColour,fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'email', labelStyle: TextStyle(color: mainTextColour)),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'password', labelStyle: TextStyle(color: mainTextColour)),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Text(_errorMessage, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _login,
              style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(boxColourLight),
                          ),
              child: Text('log in!', style: TextStyle(color: mainTextColour)),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: mainTextColour, fontWeight: FontWeight.w400),
                  children: const [
                    TextSpan(text: "don't have an account? "),
                    TextSpan(text: "sign up here", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
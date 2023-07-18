import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app2/authentication_page/log_in_page.dart';
import 'package:food_app2/main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String _errorMessage = '';

  Future<void> _signup() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        final String username = _usernameController.text;
        // create a new document in Firestore to store the user's information
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': user.email,
          'username': username
        });
        print('Signup successful. User: ${user.email}, Username: $username');
      } else {
        print('User creation failed');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'signup failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome to wrApped!', style: TextStyle(color: appBarTextColour, fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: appBarColour,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("sign up to get started :)", style: TextStyle(color: mainTextColour,fontSize: 16.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'email', labelStyle: TextStyle(color: mainTextColour)),
            ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'username', labelStyle: TextStyle(color: mainTextColour)),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'password',labelStyle: TextStyle(color: mainTextColour)),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            Text(_errorMessage, style: const TextStyle(color: Colors.red,fontSize: 16.0)),
            ElevatedButton(
              onPressed: _signup,
              style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(boxColourLight),
                          ),
              child: Text('sign up!', style: TextStyle(color: mainTextColour)),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogInPage()),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: mainTextColour, fontWeight: FontWeight.w400),
                  children: const [
                    TextSpan(text: 'already have an account? '),
                    TextSpan(text: 'log in here', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

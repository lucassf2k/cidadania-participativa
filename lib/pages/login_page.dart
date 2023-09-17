import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  late String status = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _contEmail = TextEditingController();
  final TextEditingController _contPass = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cidadania Parcipativa"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
              child: GoogleAuthButton(
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

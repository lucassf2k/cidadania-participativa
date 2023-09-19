import 'package:auth_buttons/auth_buttons.dart';
import 'package:cidadania_participativa/core/app_colors.dart';
import 'package:cidadania_participativa/core/button.dart';
import 'package:cidadania_participativa/core/input.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_service.dart';
import 'package:cidadania_participativa/firebase/response.dart';
import 'package:cidadania_participativa/pages/home_page.dart';
import 'package:cidadania_participativa/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  late String _status = "";
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
        backgroundColor: AppColors.menu,
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
            const Text(
              'Ajude sua cidade',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Reporte problemas',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            GoogleAuthButton(
              onPressed: _handleGoogleLogin,
              style: const AuthButtonStyle(
                  height: 58, buttonColor: AppColors.buttonSecondary),
            ),
            const SizedBox(height: 50),
            Input('E-mail', 'example@mail.com', _contEmail,
                inputType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            Input('Senha', '*************', _contPass,
                inputType: TextInputType.text),
            const SizedBox(height: 20),
            Button('Login com E-mail', _handleEmailLogin,
                height: 58, fontSize: 16, colorBG: AppColors.button),
            const SizedBox(height: 10),
            Button('Criar conta', _handleAccountCreate,
                height: 58, fontSize: 16, colorBG: AppColors.button),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _handleGoogleLogin() async {
    print("_onClickGoogleLogin");

    final fbService = FacadeFirebaseService();
    Response response = await fbService.loginGoogle();

    if (response.ok) {
      push(context, HomePage(), flagBack: true);
    } else {
      print("Erro: " + response.msg);
    }
  }

  Future<void> _handleEmailLogin() async {
    print("_onClickEmailLogin");

    String email = _contEmail.text;
    String pass = _contPass.text;

    _fbAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((firebaseUser) async {
      await push(context, HomePage(), flagBack: false);
    }).catchError((erro) {
      setState(() {
        _status = "Erro no login: " + erro.toString();
      });
    });

    setState(() {});
  }

  Future<void> _handleAccountCreate() async {
    print("_onClickEmailCreate");

    String email = _contEmail.text;
    String pass = _contPass.text;

    _fbAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((firebaseUser) {
      setState(() {
        _status = "Sucesso! email: ${firebaseUser.user!.email}";
      });
    }).catchError((erro) {
      setState(() {
        _status = "Erro no create: " + erro.toString();
      });
    });
  }
}

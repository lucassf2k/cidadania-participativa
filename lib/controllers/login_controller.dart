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
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;
  RxString status = "".obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController contEmail = TextEditingController();
  final TextEditingController contPass = TextEditingController();

  Future<void> handleGoogleLogin() async {
    print("handleGoogleLogin");
    final fbService = FacadeFirebaseService();
    var response = await fbService.loginGoogle();
    if (response.ok) {
      Get.toNamed('menu_page');
    } else {
      print("Erro: " + response.msg);
    }
  }

  Future<void> handleEmailLogin() async {
    print("handleEmailLogin");

    String email = contEmail.text;
    String pass = contPass.text;
    _fbAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((firebaseUser) async {
      Get.toNamed('menu_page');
    }).catchError((error) {
      status.value = "Erro no login: " + error.toString();
    });
  }

  Future<void> handleAccountCreate() async {
    print("handleAccountCreate");
    String email = contEmail.text;
    String pass = contPass.text;
    _fbAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((firebaseUser) {
      status.value = "Sucesso! email: ${firebaseUser.user!.email}";
    }).catchError((error) {
      status.value = "Erro no create: " + error.toString();
    });
  }
}

import 'dart:io';

import 'package:cidadania_participativa/core/button.dart';
import 'package:cidadania_participativa/models/report.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../core/app_colors.dart';
import '../firebase/facade_firebase_firestore.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  final fbFirestore = FacadeFirebaseFirestore();
  FirebaseStorage fbStorage = FirebaseStorage.instance;

  late String str = "";
  late String _url = "";
  TextEditingController _contID = TextEditingController();

  File? _image;
  late String? _location;
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _getLocation();
    } else {
      Get.snackbar(
        'Permissão negada',
        'Você negou a permissão de localização.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cidadania Parcipativa"),
        backgroundColor: AppColors.menu,
      ),
      body: ListView(
        padding: const EdgeInsets.all(25.0),
        children: [
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              labelText: 'Descrição',
              hintText: 'Descreva o problema',
              border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            maxLines: 5,
          ),
          SizedBox(height: 16),
          Button(
            'Tirar foto',
                () => _getImage(),
            colorBG: AppColors.button,
          ),
          SizedBox(height: 120),
          Button(
            'Registrar Report',
                () => _postReport(),
            colorBG: AppColors.button,
          ),
          SelectableText(str),
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    try{
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('Imagem não capturada');
        }
      });
    } catch (e){
      Get.snackbar(
        'Falhou!',
        'Não foi possível obter posição',
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,);
      print('Erro ao capturar foto: $e');
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _location = '${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      Get.snackbar(
        'Falhou!',
        'Não foi possível obter posição',
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,);
      print('Erro ao obter localização: $e');
    }
  }

  Future<void> _postReport() async {
    if (_textEditingController.text.isEmpty) {
      return;
    }

    if (_image != null && _location != null) {
      DateTime _now = DateTime.now();
      String _formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(_now);

      _uploadImage();

      Report rp = Report(
          id: _contID.text,
          desc: _textEditingController.text,
          photo: _url,
          geolocal: _location,
          date: _formattedDateTime);

      str = await fbFirestore.createReport(rp);

      setState(() {});
      Get.toNamed('menu_page');
    }
  }

  Future<void> _uploadImage() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = 'report_$timestamp.jpg';

    Reference arquivo = fbStorage.ref().child("reports_photos/$fileName");

    UploadTask task = arquivo.putFile(_image!);

    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
        setState(() {});
      } else if (taskSnapshot.state == TaskState.success) {
        _obterUrl(taskSnapshot, fileName); // Passar o nome do arquivo gerado
        setState(() {});
      } else if (taskSnapshot.state == TaskState.error) {
        setState(() {});
      }
    });
  }

  Future<void> _obterUrl(TaskSnapshot taskSnapshot, String fileName) async {
    try{
      String url = await taskSnapshot.ref.getDownloadURL();
      print("Url: $url");
      setState(() {
        _url = url;
      });
    } catch(e) {
      print("Não foi possivel obter o link: $e");
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

/*

  Future<void> _getImage() async {

  }

  Future<void> _uploadImage() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = 'report_$timestamp.jpg';

    Reference arquivo = fbStorage.ref().child("reports_photos/$fileName");

    UploadTask task = arquivo.putFile(_image!);


    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      if (taskSnapshot.state == TaskState.running) {
        print('Carregando...');
        setState(() {});
      } else if (taskSnapshot.state == TaskState.success) {
        _obterUrl(taskSnapshot, fileName);
        setState(() {});
      } else if (taskSnapshot.state == TaskState.error) {
        Get.snackbar(
            'Falhou!',
            'Não foi possível recuperar o URL.',
            colorText: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 6),);
        setState(() {});
      }
    });
  }



}
*/
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
        title: const Text("Cidadania Participativa"),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 30),
              _image == null
                  ? Text('Nenhuma imagem foi selecionada')
                  : Text('Imagem: ${File(_image!.path).toString()}', maxLines: 1,),
              Button(
                'Tirar foto',
                () => _getImage(),
                colorBG: AppColors.button,
              ),
            ],
          ),
          SizedBox(height: 240),
          Button(
            'Registrar Report',
            () => _postReport(),
            colorBG: AppColors.button,
          ),
        ],
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    try {
      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('Imagem não capturada');
        }
      });
    } catch (e) {
      Get.snackbar(
        'Falhou!',
        'Não foi possível obter posição',
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
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
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Erro ao obter localização: $e');
    }
  }

  /*Future<void> _postReport() async {
    if (_textEditingController.text.isEmpty) {
      return;
    }

    if (_image != null && _location != null) {
      DateTime _now = DateTime.now();
      String _formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(_now);

      await _uploadImage();
      if(_url.isNotEmpty){
        Report rp = Report(
            id: _contID.text,
            desc: _textEditingController.text,
            photo: _url,
            geolocal: _location,
            date: _formattedDateTime);

        str = await fbFirestore.createReport(rp);

        setState(() {});
        Get.toNamed('menu_page');
      } else {
        Get.snackbar(
          'Falhou',
          'Não foi possível obter a URL da imagem.',
          colorText: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }

    }
  }*/

  Future<void> _postReport() {
    if (_textEditingController.text.isEmpty) {
      return Future.value(); // Retorna uma Future vazia se a descrição estiver vazia
    }

    if (_image != null && _location != null) {
      DateTime _now = DateTime.now();
      String _formattedDateTime = DateFormat('dd/MM/yyyy HH:mm').format(_now);

      return _uploadImage().then((_) {
        Report rp = Report(
          id: _contID.text,
          desc: _textEditingController.text,
          photo: _url,
          geolocal: _location,
          date: _formattedDateTime,
        );

        return fbFirestore.createReport(rp).then((_) {
          Get.snackbar(
            'Sucesso',
            'Report registrado com sucesso!',
            colorText: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
          );

          Get.toNamed('menu_page');
        }).catchError((e) {
          Get.snackbar(
            'Erro',
            'Erro ao registrar o report no Firebase Firestore: $e',
            colorText: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      }).catchError((e) {
        print(e);
        Get.snackbar(
          'Erro',
          'Erro ao fazer o upload da imagem!',
          colorText: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        Report rp = Report(
          id: _contID.text,
          desc: _textEditingController.text,
          photo: _url,
          geolocal: _location,
          date: _formattedDateTime,
        );

        return fbFirestore.createReport(rp).then((_) {
          Get.snackbar(
            'Sucesso',
            'Report registrado com sucesso!',
            colorText: Colors.green,
            snackPosition: SnackPosition.BOTTOM,
          );

          Get.toNamed('menu_page');
        }).catchError((e) {
          Get.snackbar(
            'Erro',
            'Erro ao registrar o report no Firebase Firestore: $e',
            colorText: Colors.red,
            snackPosition: SnackPosition.BOTTOM,
          );
        });

      });
    }

    return Future.value(); // Retorna uma Future vazia se _image ou _location forem nulos
  }

  Future<void> _uploadImage() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = 'report_$timestamp.jpg';

    Reference arquivo = fbStorage.ref().child("reports_photos/$fileName");

    UploadTask task = arquivo.putFile(_image!);

    try {
      final TaskSnapshot taskSnapshot = await task;
      final String url = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _url = url;
      });
    } catch (e) {
      print("Erro durante o upload da imagem: $e");
      throw e;
    }
  }

  /*Future<void> _uploadImage() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = 'report_$timestamp.jpg';

    Reference arquivo = fbStorage.ref().child("reports_photos/$fileName");

    UploadTask task = arquivo.putFile(_image!);

    task.snapshotEvents.listen((taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("$progress% Completo.");
          setState(() {});
          break;
        case TaskState.paused:
          setState(() {});
          break;
        case TaskState.success:
          try {
            String url = await taskSnapshot.ref.getDownloadURL();
            print("Url: $url");
            setState(() {
              _url = url;
            });
          } catch (e) {
            print("Não foi possivel obter o link: $e");
          }
          break;
        case TaskState.canceled:
          setState(() {});
          break;
        case TaskState.error:
          print("falha no upload");
          setState(() {});
          break;
      }
    });
  }*/

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

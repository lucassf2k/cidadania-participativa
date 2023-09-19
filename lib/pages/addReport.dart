import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  File? _image;
  String? _location;
  TextEditingController _textEditingController = TextEditingController();

  final _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      } else {
        print('Imagem não capturada');
      }
    });
  }
  Future<void> _getLocation() async {
    try{
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      print('Erro ao obter localização: $e');
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00d90429),
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
          ElevatedButton(
            onPressed: () => _getImage,
            child: Text('Tirar foto!'),
          ),
          SizedBox(height: 16),
          if (_location != null)
            Text(
              'Localização: $_location',
              style: TextStyle(fontSize: 18),
            ),
          ElevatedButton(
            onPressed: _getLocation,
            child: Text('Obter Localização'),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Get.toNamed('mainMenuPage'),
            child: Text('Registrar Report'),
          ),

        ],
      ),
    );
  }
}


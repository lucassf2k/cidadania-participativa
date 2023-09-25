import 'dart:convert';

import 'package:cidadania_participativa/core/button.dart';
import 'package:cidadania_participativa/models/report.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../core/app_colors.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final fbFirestore = FacadeFirebaseFirestore();
  FirebaseStorage storage = FirebaseStorage.instance;

  String _neighborhood = '';
  String _street = '';
  String _postalCode = '';
  String str = "";
  String? _location = "";
  List<Report> reps = [];

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
      loadReports();
    } else {
      Get.snackbar(
        'Permissão negada',
        'Você negou a permissão de localização.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ReportController());

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Cidadania Participativa"),
              backgroundColor: AppColors.menu,
              bottom: const TabBar(
                indicatorColor: AppColors.background,
                tabs: [
                  Tab(text: 'Seus Reportes'),
                  Tab(text: 'Recentes'),
                  Tab(text: 'Mapa de reportes'),
                ],
              ),
            ),
            body: Container(
              color: AppColors.background,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: reps.length,
                    itemBuilder: (context, index) {
                      if(reps.isEmpty){
                        return SizedBox();
                      } else {
                        Report report = reps[index];
                        return Container(
                            child: Column(
                              children: [
                                _retornaImagem(report.photo),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${report.desc}',
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                _local(report.geolocal),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child:
                                  Text('Postado em: ${report.date.toString()}'),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ));  
                      }
                    },
                  ),
                  _recentes(),
                  _mapa(),
                ],
              ),
            ),
            floatingActionButton: Button(
              '+',
              () => Get.toNamed('add_report_page'),
              colorBG: AppColors.button,
            )));
  }

  _recentes(){
    DateTime _now = DateTime.now();
    DateFormat format = DateFormat('dd/MM/yyyy HH:mm');

    return ListView.builder(
      itemCount: reps.length,
      itemBuilder: (context, index) {
        if(reps.isEmpty){
          return SizedBox();
        } else {
          Report report = reps[index];

          DateTime dateReport = format.parse(report.date);

          if(dateReport.day == _now.day
          && dateReport.month == _now.month
          && dateReport.year == _now.year){
            return Container(
                child: Column(
                  children: [
                    _retornaImagem(report.photo),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${report.desc}',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _local(report.geolocal),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:
                      Text('Postado em: ${report.date.toString()}'),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ));
          }
            return Container(height: 0);
        }
      },
    );
  }

  _mapa() {
    List<Marker> map = [];
    for (int i = 0; i < reps.length; i++) {
      List<String> loc = reps[i].geolocal.split(',');
      double? lat = double.tryParse(loc[0]);
      double? long = double.tryParse(loc[1]);
      LatLng local = LatLng(lat ?? 51.0, long ?? 0.0);

      map.add(Marker(
        point: local,
        builder: (ctx) => Icon(
          Icons.location_on,
          size: 40.0,
          color: Colors.yellowAccent,
        ),
        anchorPos: AnchorPos.align(AnchorAlign.top),
      ));
    }

    List<String>? loc = _location?.split(',');
    double? lat;
    double? long;

    if(loc != null && loc.length >= 2){
      lat = double.tryParse(loc[0]);
      long = double.tryParse(loc[1]);
    } else {
      lat = 51.0;
      long = 0.0;
    }
    LatLng local = LatLng(lat ?? 51.0, long ?? 0.0);

    map.add(Marker(
      point: local,
      builder: (ctx) => Icon(
        Icons.location_on,
        size: 40.0,
        color: Colors.redAccent,
      ),
      anchorPos: AnchorPos.align(AnchorAlign.top),
    ));

    return FlutterMap(
        options: MapOptions(
          center: local,
          zoom: 16.0,
          maxZoom: 18.0,
          minZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: map,
          ),
        ],
      );
  }

  _local(String coordenates) {
    List<String>? loc = coordenates.split(',');
    double? lat = double.tryParse(loc[0]);
    double? long = double.tryParse(loc[1]);

    if (lat != null && long != null) {
      _reverseGeocode(lat, long);
      return Align(
        alignment: Alignment.centerLeft,
        child: Text('Local: $_street, $_neighborhood, $_postalCode')
      );
    } else {
      return Align(
          alignment: Alignment.centerLeft,
          child: Text('Local: Impossível encontrar local!')
      );

    }

  }

  Future<void> _reverseGeocode(double latitude, double longitude) async {
    final String nominatimUrl =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

    final response = await http.get(Uri.parse(nominatimUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        _neighborhood = data['address']['suburb'] ?? 'N/A';
        _street = data['address']['road'] ?? 'N/A';
        _postalCode = data['address']['postcode'] ?? 'N/A';
      });
    } else {
      setState(() {
        _neighborhood = 'Erro na solicitação.';
        _street = '';
        _postalCode = '';
      });
    }
  }

  Future<void> loadReports() async {
    try {
      List<Report> reports = await fbFirestore.readReport();

      setState(() {
        reps = reports;
      });
    } catch (e) {
      Get.snackbar(
        'Falhou!',
        'Não foi possível carregar os reports',
        colorText: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );

      print('Erro ao carregar reports: $e');
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

  Image _retornaImagem(String str) {
    if (str.isEmpty) {
      return Image.asset('assets/image-not-found.png',
          height: 480, width: 480, fit: BoxFit.cover);
    } else {
      return Image.network(str, fit: BoxFit.cover);
    }
  }
}

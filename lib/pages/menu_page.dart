import 'package:cidadania_participativa/controllers/ReportController.dart';
import 'package:cidadania_participativa/core/button.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_service.dart';
import 'package:cidadania_participativa/models/report.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../core/app_colors.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final fbFirestore = FacadeFirebaseFirestore();
  final _firestoreService = FacadeFirebaseService();
  FirebaseStorage fbStorage = FirebaseStorage.instance;

  late String str = "";
  late String _url = "";
  late List<Report> reps = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Cidadania Parcipativa"),
              backgroundColor: AppColors.menu,
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Seus Reportes'),
                  Tab(text: 'Recentes'),
                  Tab(text: 'Mapa de reportes'),
                ],
              ),
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: reps.length,
                    itemBuilder: (context, index) {
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
                    },
                  ),
                  ListView.builder(
                    itemCount: reps.length,
                    itemBuilder: (context, index) {
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
                    },
                  ),
                  /*ListView.builder(
                    itemCount: reps.length,
                    itemBuilder: (context, index) {
                      Report report = reps[index];

                      DateTime currentDate = DateTime.now();

                      DateTime reportDate = DateTime.parse(
                          DateFormat('yyyy/MM/dd HH:mm')
                              .format(report.date)
                      );

                      bool isToday = reportDate.year == currentDate.year &&
                          reportDate.month == currentDate.month &&
                          reportDate.day == currentDate.day;

                      if (isToday) {
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
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text('Postado em: ${report.date.toString()}'),
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),*/

                  const Center(child: Text('Conteúdo da Aba 3')),
                ],
              ),
            ),
            floatingActionButton: Button('+', () => _onClickAddReport())));
  }

  Future<void> _onClickAddReport() async {
    Report rep = Report();
    //str = await fbFirestore.createReport(rep);

    setState(() {});

    Get.toNamed('add_report_page');
  }

  Future<void> loadReports() async {
    List<Report> reports = await fbFirestore.readReport();

    setState(() {
      reps = reports;
    });
  }

  Future<void> _obterUrl(TaskSnapshot taskSnapshot, String fileName) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _url = url;
    });
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
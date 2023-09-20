import 'package:cidadania_participativa/controllers/ReportController.dart';
import 'package:cidadania_participativa/core/button.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_service.dart';
import 'package:cidadania_participativa/models/report.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
  void initState(){
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
                Tab(text: 'Feedbacks Escutados'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
          ListView.builder(
          itemCount: reps.length,
            itemBuilder: (context, index) {
              Report report = reps[index];
              return Container(
                child: Column(
                  children: [
                    _retornaImagem(''),
                    Text('${reps[index].desc}'),
                    Text('Postado em: ${reps[index].date.toString()}'),
                    SizedBox(
                      height: 30,
                    )
                  ],
                )
              );
            },
          ),
              // Conteúdo da Aba 2
              Center(child: Text('Conteúdo da Aba 2')),
              // Conteúdo da Aba 3
              Center(child: Text('Conteúdo da Aba 3')),
            ],
          ),
        floatingActionButton: Button('+', () => _onClickAddReport())

      )
    );
  }

  Future<void> _onClickAddReport() async{
    Report rep = Report();
    //str = await fbFirestore.createReport(rep);

    setState((){});
    
    Get.toNamed('add_report_page');
  }

  Future<void> loadReports() async {

    List<Report> reports = await fbFirestore.readReport();

    setState(() { reps = reports; });
  }

  Future<void> _obterUrl(TaskSnapshot taskSnapshot, String fileName) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _url = url;
    });
  }

  _retornaImagem (String str){
    if(str.isEmpty){
      return Image.network('gs://cidadnia-ativa.appspot.com/reports_photos/PHOTO-2021-05-21-19-22-54.jpg', fit:
        BoxFit.cover,);
    } else {
      Image.network(str, fit:
      BoxFit.cover);
    }
  }
}


/*
class defined_reports extends StatelessWidget {
  const defined_reports({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00d90429),
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Seus Reportes'),
            Tab(text: 'Recentes'),
            Tab(text: 'Feedbacks Escutados'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Conteúdo da Aba 1
          ListView(
            children: [
              Center(
                child: Text('teste')
              ),
            ],
          ),
          // Conteúdo da Aba 2
          Center(child: Text('Conteúdo da Aba 2')),
          // Conteúdo da Aba 3
          Center(child: Text('Conteúdo da Aba 3')),
        ],
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () => GetSnackBar(
          title: 'teste',
        ),
      ),
      /*
      * floatingActionButton: ElevatedButton(
        onPressed: () => Get.toNamed('add_report_page'),
      ),
      * */
    );
  }
}

class undefined_reports extends StatelessWidget {
  const undefined_reports({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00d90429),
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Seus Reportes'),
            Tab(text: 'Recentes'),
            Tab(text: 'Feedbacks Escutados'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Conteúdo da Aba 1
          ListView(
            children: [
              Center(
                  child: Text('Não há nada por aqui')
              ),
            ],
          ),
          // Conteúdo da Aba 2
          ListView(
            children: [
              Center(
                  child: Text('Não há nada por aqui')
              ),
            ],
          ),
          // Conteúdo da Aba 3
          ListView(
            children: [
              Center(
                  child: Text('Não há nada por aqui')
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        child: Icon(Icons.add),
        onPressed: () => GetSnackBar(
          title: 'teste',
          backgroundColor: Colors.white10,
        ),
      ),
      /*
      * floatingActionButton: ElevatedButton(
        onPressed: () => Get.toNamed('add_report_page'),
      ),
      * */
    );
  }
}
*/

import 'package:cidadania_participativa/controllers/ReportController.dart';
import 'package:cidadania_participativa/core/button.dart';
import 'package:cidadania_participativa/models/report.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/app_colors.dart';

class MenuPage extends StatefulWidget {

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final fbFirestore = FacadeFirebaseFirestore();
  late String str = "";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    return DefaultTabController(
      length: 3,
      //child: Obx( () => controller.existing_reports.value ? defined_reports() : undefined_reports()),
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
          body: defined_reports(),
        floatingActionButton: Button('+', () => _onClickAddReport())
        /*
      * floatingActionButton: ElevatedButton(
        onPressed: () => Get.toNamed('add_report_page'),
      ),
      * */
      )
    );
  }

  Future<void> _onClickAddReport() async{
    Report rep = Report();
    //str = await fbFirestore.createReport(rep);
    setState((){});
    
    Get.toNamed('add_report_page');
  }
}

TabBarView defined_reports(){
  return TabBarView(
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
    );
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

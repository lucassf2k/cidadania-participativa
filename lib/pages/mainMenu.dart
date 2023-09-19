import 'package:cidadania_participativa/controllers/ReportController.dart';
import 'package:cidadania_participativa/entity/report.dart';
import 'package:cidadania_participativa/firebase/facade_firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenu extends StatefulWidget {

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
            backgroundColor: const Color(0x00d90429),
            foregroundColor: const Color(0x00d90429),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Seus Reportes'),
                Tab(text: 'Recentes'),
                Tab(text: 'Feedbacks Escutados'),
              ],
            ),
          ),
          body: defined_reports(),
        floatingActionButton: ElevatedButton(
          child: Icon(Icons.add),
          onPressed: _onClickAddReport
        ),
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
    
    Get.toNamed('addReportPage',);
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

class Feedback extends StatelessWidget {
  const Feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 103,
      child: Stack(
        children: [
          Positioned(
            left: 177.17,
            top: 0,
            child: Container(
              width: 212.83,
              height: 103,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.50, color: Color(0xFF8D99AE)),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 182.74,
            top: 8,
            child: SizedBox(
              width: 199.46,
              height: 42,
              child: Text(
                'Mais um alagamento aqui meu deus, façam algo!',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF2B2D42),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 177.17,
              height: 103,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/177x103"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            left: 182.74,
            top: 82,
            child: SizedBox(
              width: 199.46,
              child: Text(
                'Postado em: 19/12/2019',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Color(0xFF2B2D42),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

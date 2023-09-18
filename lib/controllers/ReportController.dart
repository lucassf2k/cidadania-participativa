import 'package:get/get.dart';

import '../entity/report.dart';

class ReportController extends GetxController{
  late var existing_reports = false.obs;
  late var r = Report().obs;

  void regist_report(Report r){
    this.r.value = r;
  }
}
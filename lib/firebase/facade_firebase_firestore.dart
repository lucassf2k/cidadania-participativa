import 'package:cidadania_participativa/models/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FacadeFirebaseFirestore
{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // READ
  Future<List<Report>> readReport() async
  {
    List<Report> listObj = [];

    QuerySnapshot querySnapshot = await firestore.collection("report").get();

    for( DocumentSnapshot item in querySnapshot.docs ) {
      Map<String, dynamic>? map = item.data() as Map<String, dynamic>?;
      Report report = Report.fromJson(map!);
      report.id = item.id;
      listObj.add(report);
    }

    return listObj;
  }

  // CREATE
  Future<String> createReport(Report report) async
  {
    Map<String, dynamic> map = report.toJson();
    DocumentReference ref = await firestore.collection("report").add(map);

    return ref.id; // ID
  }

  // UPDATE (com put)
  Future<String> updateReport(String id, Report report) async
  {
    Map<String, dynamic> map = report.toJson();

    await firestore.collection("report").doc(id).set(map);

    return "OK";
  }

  // DELETE
  Future<String> deleteReport(String id) async
  {
    await firestore.collection("report").doc(id).delete();

    return "OK";
  }

}
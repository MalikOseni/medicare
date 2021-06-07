import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/Services/auth_service/auth_service.dart';
import 'package:medicare/datamodel/appointment_history.dart';
import 'package:medicare/datamodel/notification_data.dart';
import 'package:medicare/datamodel/pill_reminder.dart';
import 'package:medicare/datamodel/student_data.dart';
import 'package:medicare/utils/locator.dart';

abstract class PillDataService {
  Stream<List<PillData>> listenForPillData();




  Future<void> addDrug({PillData pillData });


  Future<void> deleteNotification ({String documentId });

}

class PillDataServiceFake extends PillDataService {
  @override
  Stream<List<PillData>> listenForPillData() async* {
    yield [

      PillData(
        name: "Paracetamol",
        intake: "2"
      ),


      PillData(
          name: "Peneciline",
          intake: "2"
      ),

    ];
  }

  @override
  Future<void> addDrug({PillData pillData}) async {


    await Future.delayed(Duration(milliseconds: 250));


  }

  @override
  Future<void> deleteNotification({String documentId}) async {


    await Future.delayed(Duration(milliseconds: 250));


  }
}

class PillDataServiceReal extends PillDataService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService _authService = locator<AuthService>();

  @override
  Stream<List<PillData>> listenForPillData() async* {
    _authService.currentUserId();

    yield* firestore.collection("users").doc(_authService.currentUserId()).collection("pills-reminder")
        .snapshots()
        .map((event) => mapData(event.docs));
  }

  List<PillData> mapData(List<DocumentSnapshot> data) {
    if (data == null) return [];

    List<PillData> dataList = [];

    data.forEach((element) {
      dataList.add(PillData.fromMap(element.data()));
    });

    return dataList;
  }


  @override
  Future<void> addDrug({  PillData pillData}) async {


    String id = firestore.collection("users").doc().id;

    pillData.documentId = id;

    await firestore.collection("users").doc(_authService.currentUserId()).collection("pills-reminder").doc(id).set(pillData.toMap());



    return 1;
  }


  @override
  Future<void> deleteNotification({  String documentId}) async {



    await firestore.collection("users").doc(_authService.currentUserId()).collection("pills-reminder").doc(documentId).delete();

    return 1;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/Services/auth_service/auth_service.dart';
import 'package:medicare/datamodel/appointment_history.dart';
import 'package:medicare/datamodel/notification_data.dart';
import 'package:medicare/datamodel/student_data.dart';
import 'package:medicare/utils/locator.dart';

abstract class AppointmentService {
  Stream<List<AppointmentHistory>> listenForStudentData();
}

class AppointmentServiceFake extends AppointmentService {
  @override
  Stream<List<AppointmentHistory>> listenForStudentData() async* {
    yield [
      AppointmentHistory(

          title: "Appointment Approved",
          time: DateTime.now().millisecondsSinceEpoch),


      AppointmentHistory(
          title: "Appointment Approved",
          time: DateTime.now().millisecondsSinceEpoch),


      AppointmentHistory(

          title: "Appointment Approved",
          time: DateTime.now().millisecondsSinceEpoch),
    ];
  }
}

class AppointmentServiceReal extends AppointmentService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService _authService = locator<AuthService>();

  @override
  Stream<List<AppointmentHistory>> listenForStudentData() async* {
    _authService.currentUserId();

    yield* firestore
        .collection("users")
        .doc(_authService.currentUserId())
        .collection("notifications")
        .snapshots()
        .map((event) => mapData(event.docs));
  }

  List<AppointmentHistory> mapData(List<DocumentSnapshot> data) {
    if (data == null) return [];

    List<AppointmentHistory> dataList = [];

    data.forEach((element) {
      dataList.add(AppointmentHistory.fromMap(element.data()));
    });

    return dataList;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicare/Services/auth_service/auth_service.dart';
import 'package:medicare/datamodel/appointment_history.dart';
import 'package:medicare/datamodel/notification_data.dart';
import 'package:medicare/datamodel/student_data.dart';
import 'package:medicare/utils/locator.dart';

abstract class AppointmentService {
  Stream<List<AppointmentHistory>> listenForAppointment();

  Future<void> bookAppointment({AppointmentHistory appointment });

}

class AppointmentServiceFake extends AppointmentService {
  @override
  Stream<List<AppointmentHistory>> listenForAppointment() async* {
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

  @override
  Future<void> bookAppointment({AppointmentHistory appointment}) async {


    await Future.delayed(Duration(milliseconds: 250));


  }
}

class AppointmentServiceReal extends AppointmentService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AuthService _authService = locator<AuthService>();

  @override
  Stream<List<AppointmentHistory>> listenForAppointment() async* {
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


  @override
  Future<void> bookAppointment({  AppointmentHistory appointment}) async {

    await firestore.collection("users").doc(_authService.currentUserId())
        .set(appointment.toMap());

    return 1;
  }
}

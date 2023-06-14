import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techigh_todo/features/todo/constants/list_model_const.dart';

class ReminderModel {
  String uid;
  String title;
  String? note;
  bool completed;

  ReminderModel({
    required this.title,
    required this.uid,
    required this.note,
    required this.completed,
  });

  ReminderModel.createReminder({
    required this.title,
    String? uid,
    String? note,
  })  : uid = uid ?? 'none',
        completed = false;

  /// Named
  // ReminderModel.named()
  //     : uid = 'uid',
  //       title = 'title',
  //       note = 'note',
  //       completed = false;

  // ReminderModel.positional({
  //   required this.uid,
  //   required this.title,
  //   required this.note,
  //   required this.completed,
  // });

  // ReminderModel.redirect(String title)
  //     : this(
  //         uid: '',
  //         title: title,
  //         note: '',
  //         completed: false,
  //       );

  ReminderModel.fromJson({
    required Map<String, dynamic> json,
  })  : uid = json['uid'],
        title = json['title'],
        note = json['note'],
        completed = json['completed'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'note': note,
      'completed': completed,
    };
  }

  factory ReminderModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ReminderModel(
      uid: data?['uid'],
      title: data?['title'],
      note: data?['note'],
      completed: data?['completed'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "uid": uid,
      "title": title,
      "note": note,
      "completed": completed,
    };
  }
}

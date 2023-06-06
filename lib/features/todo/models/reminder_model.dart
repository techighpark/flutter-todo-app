import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techigh_todo/features/todo/constants/list_model_const.dart';

class ReminderModel {
  String title;
  String? note;
  bool? completed;

  ReminderModel({
    required this.title,
    this.note,
    this.completed,
  });

  ReminderModel.fromJson({
    required Map<String, dynamic> json,
  })  : title = json[ListConstant.listItemFormKeys[ListItemType.title]!],
        note = json[ListConstant.listItemFormKeys[ListItemType.note]!],
        completed =
            json[ListConstant.listItemFormKeys[ListItemType.completed]!];

  Map<String, dynamic> toJson() {
    return {
      ListConstant.listItemFormKeys[ListItemType.title]!: title,
      ListConstant.listItemFormKeys[ListItemType.note]!: note,
      ListConstant.listItemFormKeys[ListItemType.completed]!: completed,
    };
  }

  factory ReminderModel.fromFireStore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ReminderModel(
      title: data?['title'],
      note: data?['note'],
      completed: data?['completed'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      "title": title,
      "note": note,
      "completed": false,
    };
  }
}

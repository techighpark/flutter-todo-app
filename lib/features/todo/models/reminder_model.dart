import 'package:dev_app_1/features/todo/constants/list_model_const.dart';

class ReminderModel {
  String note;
  bool completed;

  ReminderModel({
    required this.note,
    required this.completed,
  });

  ReminderModel.fromJson({
    required Map<String, dynamic> json,
  })  : note = json[ListConstant.listItemFormKeys[ListItemType.note]!],
        completed =
            json[ListConstant.listItemFormKeys[ListItemType.completed]!];

  Map<String, dynamic> toJson() {
    return {
      ListConstant.listItemFormKeys[ListItemType.note]!: note,
      ListConstant.listItemFormKeys[ListItemType.completed]!: completed,
    };
  }
}

import 'package:techigh_todo/features/todo/constants/list_model_const.dart';

class ListItemModel {
  String title;
  String note;
  bool completed;

  ListItemModel({
    required this.title,
    required this.note,
    required this.completed,
  });

  ListItemModel.fromJson({
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
}

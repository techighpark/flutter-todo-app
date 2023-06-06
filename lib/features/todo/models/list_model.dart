import 'package:dev_app_1/features/todo/constants/list_model_const.dart';
import 'package:dev_app_1/features/todo/views/new_list_modal_view.dart';
import 'package:flutter/cupertino.dart';

class ListModel {
  final String id;
  final String title;
  final String icon;
  final String color;
  final int createdAt;

  ListModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.createdAt,
  });

  ListModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json[ListConstant.listFormKeys[ListType.id]!],
        title = json[ListConstant.listFormKeys[ListType.title]!],
        color = json[ListConstant.listFormKeys[ListType.color]!],
        icon = json[ListConstant.listFormKeys[ListType.icon]!],
        createdAt = json[ListConstant.listFormKeys[ListType.createdAt]!];

  Map<String, dynamic> toJson() {
    return {
      ListConstant.listFormKeys[ListType.id]!: id,
      ListConstant.listFormKeys[ListType.title]!: title,
      ListConstant.listFormKeys[ListType.color]!: color,
      ListConstant.listFormKeys[ListType.icon]!: icon,
      ListConstant.listFormKeys[ListType.createdAt]!: createdAt,
    };
  }
}

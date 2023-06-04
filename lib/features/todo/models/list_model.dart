import 'package:dev_app_1/features/todo/constants/list_model_const.dart';
import 'package:dev_app_1/features/todo/views/new_list_modal_view.dart';
import 'package:flutter/cupertino.dart';

class ListModel {
  String title;
  String icon;
  String color;

  ListModel({
    required this.title,
    required this.icon,
    required this.color,
  });

  ListModel.fromJson({
    required Map<String, dynamic> json,
  })  : title = json[ListConstant.listFormKeys[ListType.title]!],
        color = json[ListConstant.listFormKeys[ListType.color]!],
        icon = json[ListConstant.listFormKeys[ListType.icon]!];

  Map<String, dynamic> toJson() {
    return {
      ListConstant.listFormKeys[ListType.title]!: title,
      ListConstant.listFormKeys[ListType.color]!: color,
      ListConstant.listFormKeys[ListType.icon]!: icon,
    };
  }
}

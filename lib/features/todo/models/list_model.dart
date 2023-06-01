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
  })  : title = json['title'],
        color = json['color'],
        icon = json['icon'];

  Map<String, dynamic> toJson() {
    return {
      formKeys[ListModelType.title]!: title,
      formKeys[ListModelType.color]!: color,
      formKeys[ListModelType.icon]!: icon,
    };
  }
}

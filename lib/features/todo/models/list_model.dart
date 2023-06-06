import 'package:techigh_todo/features/todo/constants/list_model_const.dart';
import 'package:techigh_todo/features/todo/views/new_list_modal_view.dart';
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

  // ListModel copyWith({
  //   String? id,
  //   String? title,
  //   String? icon,
  //   String? color,
  //   int? createdAt,
  // }) {
  //   return ListModel(
  //     id: id ?? this.id,
  //     title: title ?? this.title,
  //     icon: icon ?? this.icon,
  //     color: color ?? this.color,
  //     createdAt: createdAt ?? this.createdAt,
  //   );
  // }

  ListModel.fromJson({
    required Map<String, dynamic> json,
  })  : id = json[ListConstant.listFormKeys[ListType.id]!],
        title = json[ListConstant.listFormKeys[ListType.title]!],
        color = json[ListConstant.listFormKeys[ListType.color]!],
        icon = json[ListConstant.listFormKeys[ListType.icon]!],
        createdAt = json[ListConstant.listFormKeys[ListType.createdAt]!];

  Map<String, dynamic> toJson(String documentId) {
    return {
      ListConstant.listFormKeys[ListType.id]!: documentId,
      ListConstant.listFormKeys[ListType.title]!: title,
      ListConstant.listFormKeys[ListType.color]!: color,
      ListConstant.listFormKeys[ListType.icon]!: icon,
      ListConstant.listFormKeys[ListType.createdAt]!: createdAt,
    };
  }
}

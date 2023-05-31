import 'dart:convert';
import 'package:dev_app_1/features/todo/models/list_model.dart';
import 'package:dev_app_1/features/todo/repos/list_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewModel extends Notifier<List<ListModel>> {
  final ListRepository _repository;
  late final List<ListModel> _list;
  ListViewModel(this._repository);

  @override
  List<ListModel> build() {
    List<String> encodedList = _repository.getList();
    List<ListModel> list = [];
    for (final item in encodedList) {
      final decodedItem = json.decode(item);
      list.add(decodedItem);
    }
    return list;
  }
}

final listProvider = NotifierProvider<ListViewModel, List<ListModel>>(() {
  throw UnimplementedError();
});

import 'dart:convert';
import 'package:dev_app_1/features/todo/models/list_model.dart';
import 'package:dev_app_1/features/todo/repos/list_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewModel extends Notifier<List<ListModel>> {
  final ListRepository _repository;
  late final List<ListModel> _list = [];

  ListViewModel(this._repository);

  List<ListModel> getList() {
    List<String> encodedList = _repository.getList();
    for (final item in encodedList) {
      final decodedItem = json.decode(item);
      _list.add(ListModel.fromJson(json: decodedItem));
    }
    return _list;
  }

  @override
  List<ListModel> build() {
    return getList();
  }

  void addList(ListModel value) {
    final List<String> encodedList = _repository.getList();
    // final toStringValue = value.toString();
    final toJsonValue = json.encode(value.toJson());
    encodedList.add(toJsonValue);
    _repository.setList(encodedList);
    state = getList();
  }
}

final listProvider = NotifierProvider<ListViewModel, List<ListModel>>(() {
  throw UnimplementedError();
});

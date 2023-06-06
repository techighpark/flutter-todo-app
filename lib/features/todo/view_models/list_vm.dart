import 'dart:convert';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/repos/list_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListViewModel extends Notifier<List<ListModel>> {
  final ListRepository _repository;

  ListViewModel(this._repository);

  @override
  List<ListModel> build() {
    late final List<ListModel> list = [];
    List<String> encodedList = _repository.getList();
    for (final item in encodedList) {
      final decodedItem = json.decode(item);
      list.add(ListModel.fromJson(json: decodedItem));
    }
    return list;
  }

  void addList(ListModel value) {
    print('addList');

    /// existed list
    final List<String> encodedList = _repository.getList();

    /// Convert appended item to string
    final toJsonValue = json.encode(value.toJson());

    encodedList.add(toJsonValue);
    _repository.setList(encodedList);
    state = [...state, value];
  }
}

final listProvider = NotifierProvider<ListViewModel, List<ListModel>>(() {
  throw UnimplementedError();
});

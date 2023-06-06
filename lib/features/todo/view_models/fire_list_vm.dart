import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/repos/fire_list_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireListViewModel extends AsyncNotifier<List<ListModel>> {
  late final FireListRepository _repository;
  List<ListModel> _list = [];

  @override
  FutureOr<List<ListModel>> build() async {
    print('fire_list_vm : build');
    _repository = ref.read(fireListRepo);
    _list = await _fetchLists();
    return _list;
  }

  Future<List<ListModel>> _fetchLists() async {
    print('fire_list_vm : _fetchLists');
    final result = await _repository.fetchLists();
    final lists = result.docs.map(
      (chat) => ListModel.fromJson(
        json: chat.data(),
      ),
    );
    return lists.toList();
  }

  Future<void> addList(ListModel list) async {
    print('fire_list_vm : addList');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _repository.addList(list);
      return _fetchLists();
    });
  }
}

final listProvider = AsyncNotifierProvider<FireListViewModel, List<ListModel>>(
    () => FireListViewModel());

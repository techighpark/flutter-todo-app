import 'dart:async';
import 'dart:developer';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/repos/fire_lists_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListsViewModel extends AsyncNotifier<List<ListModel>> {
  late final FireListRepository _listsRepository;

  @override
  FutureOr<List<ListModel>> build() async {
    log('build', name: ':::  EXECUTE  ::: Lists VM');

    _listsRepository = ref.read(fireListsRepo);
    List<ListModel> list = await _fetchLists();
    return list;
  }

  Future<List<ListModel>> _fetchLists() async {
    log('_fetchLists', name: ':::  EXECUTE  ::: Lists VM');

    final result = await _listsRepository.fetchLists();
    final lists = result.docs.map(
      (list) => ListModel.fromJson(
        json: list.data(),
      ),
    );

    return lists.toList();
  }

  /// create new list
  Future<void> addList(ListModel list) async {
    log('addList', name: ':::  EXECUTE  ::: Lists VM');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        _listsRepository.addList(list.toJson());
        return _fetchLists();
      },
    );
  }

  /// delete list
  Future<void> deleteList(String listId) async {
    log('deleteList', name: ':::  EXECUTE  ::: Lists VM');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _listsRepository.deleteList(listId);
        return _fetchLists();
      },
    );
  }
}

final listsProvider = AsyncNotifierProvider<ListsViewModel, List<ListModel>>(
  () => ListsViewModel(),
);

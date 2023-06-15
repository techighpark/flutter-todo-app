import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/reminder_model.dart';
import 'package:techigh_todo/features/todo/repos/fire_reminders_repo.dart';

class RemindersViewModel
    extends FamilyAsyncNotifier<List<ReminderModel>, String> {
  late final FireRemindersRepository _repository;
  List<ReminderModel> _list = [];

  @override
  FutureOr<List<ReminderModel>> build(String listId) async {
    print('fire_reminders_vm - build');

    print(listId);
    _repository = ref.read(fireRemindersRepo);
    _list = await _fetchReminders(listId);
    return _list;
  }

  Future<List<ReminderModel>> _fetchReminders(String listId) async {
    print('fire_reminders_vm - _fetchReminders');

    final result = await _repository.fetchReminders(listId);
    final list = result.docs.map(
      (reminder) => ReminderModel.fromJson(
        json: reminder.data(),
      ),
    );
    return list.toList();
  }

  Future<void> addReminder(String listId, String title) async {
    print('fire_reminders_vm - addReminder');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final reminder = ReminderModel.createReminder(title: title).toJson();
      _repository.addReminder(listId, reminder);
      return _fetchReminders(listId);
    });
  }

  Future<void> updateCompleteReminder(String reminderId, bool complete) async {
    /// TODO AsyncValue
    state = AsyncValue.loading();

    /// 비동기 데이터 - 새로 고침 중인지 여부
    print(state.isRefreshing);

    /// 비동기 데이터 - 다시 로드 중인지 여부
    /// 일반적으로 자동으로 발생하는 주기적인 갱신 작업 등에 의해 사용
    print(state.isReloading);

    // state = await AsyncValue.guard(() async {
    //   _repository.updateCompleteReminder(reminderId, complete);
    // });
  }
}

final remindersProvider = AsyncNotifierProvider.family<RemindersViewModel,
    List<ReminderModel>, String>(() => RemindersViewModel());

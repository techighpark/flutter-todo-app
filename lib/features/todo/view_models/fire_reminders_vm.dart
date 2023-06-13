import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/reminder_model.dart';
import 'package:techigh_todo/features/todo/repos/fire_reminders_repo.dart';

class FireRemindersViewModel
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

  Future<void> addReminder(String listId, String value) async {
    print('fire_reminders_vm - addReminder');
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final reminder = ReminderModel(title: value).toJson();
      _repository.addReminder(listId, reminder);
      return _fetchReminders(listId);
    });
  }

  Future<void> updateCompleteReminder(String reminderId, bool complete) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      _repository.updateCompleteReminder(reminderId, complete);
    });
  }
}

final remindersProvider = AsyncNotifierProvider.family<FireRemindersViewModel,
    List<ReminderModel>, String>(() => FireRemindersViewModel());

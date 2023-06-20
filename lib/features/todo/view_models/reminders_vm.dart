import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/reminder_model.dart';
import 'package:techigh_todo/features/todo/repos/fire_reminders_repo.dart';

class RemindersViewModel
    extends FamilyAsyncNotifier<List<ReminderModel>, String> {
  late final FireRemindersRepository _repository;
  List<ReminderModel> _list = [];

  @override
  FutureOr<List<ReminderModel>> build(String listId) async {
    log('build', name: ':::  EXECUTE  ::: Reminders VM');

    _repository = ref.read(fireRemindersRepo);
    _list = await _fetchReminders(listId);
    return _list;
  }

  Future<List<ReminderModel>> _fetchReminders(String listId) async {
    log('_fetchReminders', name: ':::  EXECUTE  ::: Reminders VM');

    final result = await _repository.fetchReminders(listId);
    final list = result.docs.map(
      (reminder) => ReminderModel.fromJson(
        json: reminder.data(),
      ),
    );
    return list.toList();
  }

  Future<void> addReminder(String listId, String title) async {
    log('addReminder', name: ':::  EXECUTE  ::: Reminders VM');

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final reminder = ReminderModel.createReminder(title: title).toJson();
      _repository.addReminder(listId, reminder);
      return _fetchReminders(listId);
    });
  }

  Future<void> updateCompleteReminder(
      String listId, String reminderId, bool value) async {
    log('updateCompleteReminder', name: ':::  EXECUTE  ::: Reminders VM');

    final List<ReminderModel> currentState = state.value!;

    final index =
        currentState.indexWhere((element) => element.uid == reminderId);

    if (index != -1) {
      final currentElement = currentState[index];
      final updatedElement = {
        'uid': reminderId,
        'completed': value,
        'note': currentElement.note,
        'title': currentElement.title,
      };
      currentState[index] = ReminderModel.fromJson(json: updatedElement);
      state = AsyncValue.data(currentState);
      await _repository
          .updateCompleteReminder(listId, reminderId, {'completed': value});
    }
  }
}

final remindersProvider = AsyncNotifierProvider.family<RemindersViewModel,
    List<ReminderModel>, String>(() => RemindersViewModel());

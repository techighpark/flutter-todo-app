import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';
import 'package:techigh_todo/features/todo/models/reminder_model.dart';

class FireRemindersRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// fetch, pagination, infinite scroll
  Future<QuerySnapshot<Map<String, dynamic>>> fetchReminders(String listId) {
    print('fire_reminders_repo - fetchReminders');
    final query = _db.collection("list").doc(listId).collection('reminder');
    return query.get();
  }

  Future<void> addReminder(String listId, Map<String, dynamic> reminder) async {
    print('fire_reminders_repo - addReminder');
    await _db
        .collection('list')
        .doc(listId)
        .collection('reminder')
        .add(reminder)
        .then((value) async => await _db
            .collection('list')
            .doc(listId)
            .collection('reminder')
            .doc(value.id)
            .update({'uid': value.id}));
  }

  Future<void> updateCompleteReminder(
      String reminderId, Map<String, dynamic> data) async {
    print('fire_reminders_repo - updateCompleteReminder');

    await _db.collection('reminder').doc(reminderId).update(data);
  }
}

final fireRemindersRepo = Provider((ref) => FireRemindersRepository());

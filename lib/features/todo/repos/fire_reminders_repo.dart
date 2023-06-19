import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireRemindersRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// fetch, pagination, infinite scroll
  Future<QuerySnapshot<Map<String, dynamic>>> fetchReminders(String listId) {
    log('fetchReminders', name: 'RemindersRepository - Call');
    final query = _db.collection("list").doc(listId).collection('reminder');
    return query.get();
  }

  Future<void> addReminder(String listId, Map<String, dynamic> reminder) async {
    log('addReminder', name: 'RemindersRepository - Call');

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
      String listId, String reminderId, Map<String, dynamic> data) async {
    log('updateCompleteReminder', name: 'RemindersRepository - Call');

    try {
      await _db
          .collection('list')
          .doc(listId)
          .collection('reminder')
          .doc(reminderId)
          .update(data);

      log('updateCompleteReminder', name: 'RemindersRepository - SUCCESS');
    } catch (err) {
      log(err.toString(), name: 'RemindersRepository - ERROR');
    }
  }
}

final fireRemindersRepo = Provider((ref) => FireRemindersRepository());

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';

class FireListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// fetch, pagination, infinite scroll [??]
  Future<QuerySnapshot<Map<String, dynamic>>> fetchLists() {
    log('fetchLists', name: ':::  EXECUTE  ::: Lists Repo');

    final query = _db.collection("list");
    return query.get();
  }

  /// add new list
  Future<void> addList(Map<String, dynamic> list) async {
    log('addList', name: ':::  EXECUTE  ::: Lists Repo');

    await _db
        .collection('list')
        .doc(list['id'])
        .set(list, SetOptions(merge: true));
  }

  /// delete list
  Future<void> deleteList(String listId) async {
    log('deleteList', name: ':::  EXECUTE  ::: Lists Repo');

    /// find list
    DocumentReference listRef = _db.collection('list').doc(listId);

    /// find reminders of list
    QuerySnapshot reminderSnapshot = await listRef.collection('reminder').get();

    List<QueryDocumentSnapshot> reminderDocs = reminderSnapshot.docs;

    /// delete reminders of list
    for (QueryDocumentSnapshot reminder in reminderDocs) {
      await reminder.reference.delete();
    }

    /// delete list
    await listRef.delete();
  }
}

final fireListsRepo = Provider(
  (ref) => FireListRepository(),
);

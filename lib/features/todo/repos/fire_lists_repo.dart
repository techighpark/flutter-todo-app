import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';

class FireListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// fetch, pagination, infinite scroll [??]
  Future<QuerySnapshot<Map<String, dynamic>>> fetchLists() {
    log('fetchLists', name: 'lists_repository');
    final query = _db.collection("list");
    return query.get();
  }

  Future<void> addList(Map<String, dynamic> list) async {
    log('addList', name: 'lists_repository');
    await _db
        .collection('list')
        .doc(list['id'])
        .set(list, SetOptions(merge: true));
  }

  Future<void> deleteList(String listId) async {
    log('deleteList', name: 'lists_repository');

    DocumentReference listRef = _db.collection('list').doc(listId);
    QuerySnapshot reminderSnapshot = await listRef.collection('reminder').get();
    List<QueryDocumentSnapshot> reminderDocs = reminderSnapshot.docs;
    for (QueryDocumentSnapshot reminder in reminderDocs) {
      await reminder.reference.delete();
    }
    await listRef.delete();
  }
}

final fireListsRepo = Provider(
  (ref) => FireListRepository(),
);

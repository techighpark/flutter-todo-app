import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:techigh_todo/features/todo/models/list_model.dart';

class FireListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// fetch, pagination, infinite scroll
  Future<QuerySnapshot<Map<String, dynamic>>> fetchLists() {
    print('chat_room_repo - fetchChatRooms');
    final query = _db.collection("list");
    return query.get();
  }

  Future<void> addList(ListModel list) async {
    final documentRef = _db.collection('list').doc();
    await documentRef.set(list.toJson(documentRef.id));
  }
}

final fireListRepo = Provider((ref) => FireListRepository());

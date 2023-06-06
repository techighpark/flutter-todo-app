import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FireListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> getList() async {
    final query =
        _db.collection("list").orderBy("createdAt", descending: true).limit(2);
  }
}

final fireListRepo = Provider((ref) => FireListRepository());

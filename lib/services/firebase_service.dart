import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new task
  Future<void> addTask(Map<String, dynamic> taskData) async {
    await _firestore.collection('tasks').add(taskData);
  }

  // Get all tasks
  Stream<QuerySnapshot> getTasks() {
    return _firestore.collection('tasks').snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Task>> fetchTasks() async {
    final snapshot = await _firestore.collection('tasks').get();
    return snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add(task.toJson());
  }
}

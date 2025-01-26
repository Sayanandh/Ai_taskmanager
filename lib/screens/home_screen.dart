import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../services/openai_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final OpenAIService _openAIService = OpenAIService();
  final TextEditingController _taskController = TextEditingController();

  void _addTask() async {
    final userInput = _taskController.text;

    try {
      final taskDetails = await _openAIService.processTaskInput(userInput);
      await _firebaseService.addTask(taskDetails);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Task added successfully!'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add task'),
      ));
    }

    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Task Manager')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Enter your task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addTask,
            child: Text('Add Task'),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firebaseService.getTasks(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final tasks = snapshot.data.docs;
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task['taskName']),
                      subtitle: Text('Due: ${task['dueDate']}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

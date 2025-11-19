import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../utils/id_generator.dart';
import 'add_task_screen.dart';
import '../completed_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [
    Task(id: '1', title: 'Welcome to the demo app!'),
    Task(id: '2', title: 'Add your first task'),
  ];

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(id: generateId(), title: title));
    });
  }

  void _toggleTask(Task task) {
    setState(() {
      task.toggleCompleted();
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = _tasks.where((task) => !task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CompletedTasksScreen(
                    tasks: _tasks,
                    onToggleTask: _toggleTask,
                    onDeleteTask: _deleteTask,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Completed Tasks'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CompletedTasksScreen(
                      tasks: _tasks,
                      onToggleTask: _toggleTask,
                      onDeleteTask: _deleteTask,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: pendingTasks.isEmpty
          ? const Center(
              child: Text('All tasks completed!'),
            )
          : ListView.builder(
              itemCount: pendingTasks.length,
              itemBuilder: (context, index) {
                final task = pendingTasks[index];
                return TaskTile(
                  task: task,
                  onToggle: () => _toggleTask(task),
                  onDelete: () => _deleteTask(task),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (result != null && result is String) {
            _addTask(result);
          }
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
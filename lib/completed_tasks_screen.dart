import 'package:flutter/material.dart';
import 'models/task.dart';
import 'widgets/task_tile.dart';

class CompletedTasksScreen extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onToggleTask;
  final Function(Task) onDeleteTask;

  const CompletedTasksScreen({
    super.key,
    required this.tasks,
    required this.onToggleTask,
    required this.onDeleteTask,
  });

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final completedTasks = widget.tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: completedTasks.isEmpty
          ? const Center(
              child: Text('No completed tasks yet!'),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];
                return TaskTile(
                  task: task,
                  onToggle: () => widget.onToggleTask(task),
                  onDelete: () => widget.onDeleteTask(task),
                );
              },
            ),
    );
  }
}
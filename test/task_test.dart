import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/models/task.dart';

void main() {
  group('Task Model', () {
    test('should create a task with default values', () {
      final task = Task(id: '1', title: 'Test Task');
      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.isCompleted, false);
    });

    test('should toggle completion status', () {
      final task = Task(id: '1', title: 'Test Task');
      task.toggleCompleted();
      expect(task.isCompleted, true);
      task.toggleCompleted();
      expect(task.isCompleted, false);
    });

    test('should create a copy with updated values', () {
      final task = Task(id: '1', title: 'Test Task');
      final updatedTask = task.copyWith(title: 'Updated Task', isCompleted: true);
      expect(updatedTask.id, '1');
      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.isCompleted, true);
      expect(task.title, 'Test Task'); // original unchanged
    });
  });
}
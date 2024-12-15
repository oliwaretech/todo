import 'package:todo/app/features/home/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<List<Task>> getTaskFromApi();
}
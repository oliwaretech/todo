
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/common/helpers/constans.dart';
import 'package:todo/app/features/home/domain/entities/task.dart';
import 'package:todo/app/features/home/domain/repositories/task_repository.dart';
import 'package:http/http.dart' as http;

class TaskRepositoryImpl implements TaskRepository {
  final Ref ref;

  TaskRepositoryImpl(this.ref);

  @override
  Future<List<Task>> getTasks() async {

    return [];
  }

  @override
  Future<List<Task>> getTaskFromApi() async {
    try {
      Uri url = Uri.parse('$baseUrl/todo');
      final response = await http.get(url);
    } catch (e) {
      rethrow;
    }
    return [];
  }

}
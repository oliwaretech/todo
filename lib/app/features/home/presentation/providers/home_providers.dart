
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/app/features/home/data/repositories/task_repository_impl.dart';
import 'package:todo/app/features/home/domain/repositories/task_repository.dart';

final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepositoryImpl(ref);
});
final taskProvider = Provider(TaskProvider.new);

class TaskProvider {
  TaskProvider(this.ref);
  final Ref ref;

  Future<void> getTaskFromApi() async {
    final repository = ref.read(taskRepositoryProvider);
    await repository.getTaskFromApi();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/features/home/domain/entities/task.dart';

class AddNewTaskDialogWidget extends StatefulWidget {
  final Box<Task> taskBox;
  const AddNewTaskDialogWidget({super.key,
    required this.taskBox,
  });

  @override
  State<AddNewTaskDialogWidget> createState() => _AddNewTaskDialogWidgetState();
}

class _AddNewTaskDialogWidgetState extends State<AddNewTaskDialogWidget> {

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add New Task'),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: taskTitleController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.task_name,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: taskDescriptionController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.start,
              textInputAction: TextInputAction.next,
              maxLines: 3,
              minLines: 3,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.task_description,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  addNewTask();
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context)!.add_new_task),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addNewTask() {
    final newTask = Task(
      title: taskTitleController.text,
      description: taskDescriptionController.text,
      status: 'pending',
    );
    widget.taskBox.add(newTask);
  }
}

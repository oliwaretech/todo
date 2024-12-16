import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/app/common/extensions/build_context_extensions.dart';
import 'package:todo/app/common/helpers/notifications/app_notifications.dart';
import 'package:todo/app/features/home/domain/entities/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({
    super.key,
    required this.task,
  });

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        taskDetailDialog(context, widget.task);
      },
      child: Slidable(
          endActionPane: ActionPane(
            motion: ScrollMotion(), // Animation for revealing actions
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.task.delete();
                    AppNotifications.showSuccess(label: 'Task Deleted', message: 'Task has been deleted');
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    color: Colors.red,
                    child: const Center(
                        child: Icon(Icons.delete_forever_rounded, size: 32, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
          key: Key(widget.task.title),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.task.status == 'done' ? true : false,
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              widget.task.status = 'done';
                            } else {
                              widget.task.status = 'pending';
                            }
                            widget.task.save();
                          });
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                      widget.task.title,
                      style: widget.task.status == 'pending'
                          ? context.textTheme.bodyMedium
                          : const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                    )),
                    InkWell(
                      onTap: (){
                        editTaskDialog(context, widget.task);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.edit_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.grey,
              )
            ],
          )),
    );
  }

  Future editTaskDialog(BuildContext context, Task task) async{
    final taskTitleController = TextEditingController(text: task.title);
    final taskDescriptionController = TextEditingController(text: task.description);

    return showDialog(
      context: context,
      builder: (context){
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
                      task.title = taskTitleController.text;
                      task.description = taskDescriptionController.text;
                      task.save();
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.update_task),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future taskDetailDialog(BuildContext context, Task task) async{
    return showDialog(
      context: context,
      builder: (context){
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Task Details',),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Title: ${task.title}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Description: ${task.description}'),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/app/common/extensions/build_context_extensions.dart';
import 'package:todo/app/common/providers/secure_storage_provider.dart';
import 'package:todo/app/common/providers/theme_provider.dart';
import 'package:todo/app/core/themes/app_colors.dart';
import 'package:todo/app/features/auth/presentation/screens/login_screen.dart';
import 'package:todo/app/features/home/domain/entities/task.dart';
import 'package:todo/app/features/home/presentation/providers/home_providers.dart';
import 'package:todo/app/features/home/presentation/widgets/add_new_task_dialog_widget.dart';
import 'package:todo/app/features/home/presentation/widgets/task_widget.dart';
import 'package:todo/app/features/home/presentation/widgets/toggle_button_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  static const String route = '/';
  static const String name = 'home';

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Box<Task> taskBox = Hive.box<Task>('tasks');
  List<Task> filteredTaskList = [], tasksList = [];
  final searchTaskController = TextEditingController();
  final searchQueryProvider = StateProvider<String>((ref) => '');
  final statusFilterProvider = StateProvider<dynamic>((ref) => null);
  int taskCount = 0, doneTaskCount = 0, pendingTaskCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTaskFromApi();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;
    final searchQuery = ref.watch(searchQueryProvider);
    final statusFilter = ref.watch(statusFilterProvider);
    final platform = Theme.of(context).platform;
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: platform == TargetPlatform.android
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: isDarkMode == true
                      ? AppColors.primaryDarkText
                      : AppColors.primary,
                ),
                onPressed: () {
                  context.goNamed(LoginScreen.name);
                },
              )
            : GestureDetector(
                onTap: () {
                  context.goNamed(LoginScreen.name);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    CupertinoIcons.back,
                    size: 28,
                    color: isDarkMode == true
                        ? AppColors.primaryDarkText
                        : AppColors.primary,
                  ),
                ),
              ),
        actions: [
          if (platform == TargetPlatform.android)
            PopupMenuButton<String>(
              onSelected: (value) {
                _handleMenuSelection(context, value);
              },
              icon: Icon(Icons.more_vert,
                  color: isDarkMode == true
                      ? AppColors.primaryDarkText
                      : AppColors.primary),
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'option1',
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        'Dark Theme',
                        style: context.textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      )),
                      CustomToggleButton(
                          platform: platform,
                          darkMode: isDarkMode,
                          onChanged: (val) {
                            themeNotifier.toggleTheme();
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'option2',
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _handleMenuSelection(context, 'Profile Information');
                      },
                      child: Text(
                        'Profile Information',
                        style: context.textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      )),
                ),
                PopupMenuItem(
                  value: 'option3',
                  child: InkWell(
                    onTap: () {
                      ref.read(secureStorageProvider.notifier).deleteToken();
                      context.goNamed(LoginScreen.name);
                    },
                    child: Text('Logout',
                        style: context.textTheme.titleMedium!
                            .copyWith(color: Colors.red)),
                  ),
                )
              ],
            )
          else
            IconButton(
              icon: Icon(
                CupertinoIcons.ellipsis,
                color: isDarkMode == true
                    ? AppColors.primaryDarkText
                    : AppColors.primary,
              ),
              onPressed: () {
                _showCupertinoDialog(context);
              },
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.my_tasks,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.home_subtitle,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchTaskController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.search_task,
                ),
                onChanged: (query) {
                  ref.read(searchQueryProvider.notifier).state = query;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonFormField<dynamic>(
                value: statusFilter,
                onChanged: (status) {
                  ref.read(statusFilterProvider.notifier).state = status;
                },
                decoration: InputDecoration(
                  labelText: 'Filter by status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: null, child: Text('All')),
                  DropdownMenuItem(value: 'pending', child: Text('Pending')),
                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: taskBox.listenable(),
                builder: (context, Box<Task> box, _) {
                  taskCount = box.length;
                  doneTaskCount =
                      box.values.where((task) => task.status == 'done').length;
                  pendingTaskCount = box.values
                      .where((task) => task.status == 'pending')
                      .length;
                  final tasks = box.values.where((task) {
                    final matchesQuery = task.title
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase());
                    final matchesStatus =
                        statusFilter == null || task.status == statusFilter;

                    return matchesQuery && matchesStatus;
                  }).toList();
                  if (tasks.isEmpty) {
                    return const Center(child: Text('No matching tasks found'));
                  }

                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskWidget(task: task);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    showAddNewTaskDialog(context);
                  },
                  child: Text(AppLocalizations.of(context)!.add_new_task),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Handle menu selection for Material
  void _handleMenuSelection(BuildContext context, String value) {
    final token = ref.read(secureStorageProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(value),
        content: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.person_2_rounded,
                size: 60,
                color: AppColors.primary,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'User Token',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(token!),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.task,
                    color: AppColors.primary,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(child: Text('Total Task: $taskCount')),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(child: Text('Done Task: $doneTaskCount')),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.pending_actions,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(child: Text('Pending Task: $pendingTaskCount')),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Show Cupertino dialog
  void _showCupertinoDialog(BuildContext context) {
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          children: [
            Expanded(
                child: Text(
              'Dark Theme',
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.start,
            )),
            CustomToggleButton(
                platform: Theme.of(context).platform,
                darkMode: isDarkMode,
                onChanged: (val) {
                  themeNotifier.toggleTheme();
                  Navigator.pop(context);
                }),
          ],
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _handleMenuSelection(
                context,
                'Profile Information',
              );
            },
            child: Text(
              'Profile Information',
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.start,
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              ref.read(secureStorageProvider.notifier).deleteToken();
              context.goNamed(LoginScreen.name);
            },
            child: Text('Logout',
                style:
                    context.textTheme.titleMedium!.copyWith(color: Colors.red)),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future getTaskFromApi() async {
    final listOfTaskFromApi = ref.read(taskRepositoryProvider);
    List<Task> listOfTask = await listOfTaskFromApi.getTaskFromApi();
    if (taskBox.isEmpty) {
      for (var task in listOfTask) {
        await taskBox.add(task);
      }
    }
  }

  Future showAddNewTaskDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AddNewTaskDialogWidget(
        taskBox: taskBox,
      ),
    );
  }
}

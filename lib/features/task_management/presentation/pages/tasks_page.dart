import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pomodore/core/extensions/sized_box_extension.dart";
import "package:pomodore/core/shared_widgets/base_app_bar.dart";
import "package:pomodore/core/shared_widgets/global_indicator.dart";
import "package:pomodore/core/utils/responsive/size_config.dart";
import "package:pomodore/features/task_management/presentation/blocs/home_bloc/home_bloc.dart";
import "package:pomodore/features/task_management/presentation/blocs/tasks_bloc/tasks_bloc.dart";
import "package:pomodore/features/task_management/presentation/pages/add_task_page.dart";
import "package:pomodore/features/task_management/presentation/pages/home_widgets/home_goal_widget.dart";
import "package:pomodore/features/task_management/presentation/pages/home_widgets/home_task_count_widget.dart";
import "package:pomodore/features/task_management/presentation/pages/home_widgets/home_tasks_list.dart";
import "package:pomodore/features/task_management/presentation/shared_widgets/daily_goal_dialog.dart";

import "../../../../di.dart";
import "../../../../exports.dart";
import "../../domain/entities/task_entity.dart";

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksBloc>(
          create: (context) => getIt.get<TasksBloc>()
            ..add(
              const AllTasksFetched(),
            ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => getIt.get<HomeBloc>()
            ..add(
              DailyGoalChecked(),
            ),
        ),
      ],
      child: const TaskView(),
    );
  }
}

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late List<TaskEntity> tasksList;

  @override
  void initState() {
    tasksList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations localization = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<TasksBloc, TasksState>(
          listener: (context, state) {
            if (state is TaskCompleteSuccess ||
                state is EditTaskSuccess ||
                state is TaskDeleteSuccess) {
              context.read<TasksBloc>().add(const AllTasksFetched());
              Navigator.pop(context);
            }

            if (state is TaskCompleteFailure || state is TaskDeleteFailure) {
              Navigator.pop(context);
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is CheckDailyGoalSuccess) {
              if (state.dailyGoalSubmitted == false) {
                showDailyGoalDialog(context, context.read<HomeBloc>());
              } else {
                context.read<HomeBloc>().add(HomeDataFetched(DateTime.now()));
              }
            } else if (state is SaveDailyGoalSuccess) {
              Navigator.pop(context);
              context.read<HomeBloc>().add(HomeDataFetched(DateTime.now()));
            }
          },
        ),
      ],
      child: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          if (state is GetAllTasksSuccess) {
            tasksList = state.list;
          }

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pushNamed(context, AddTaskPage.routeName).then(
                (_) {
                  context.read<TasksBloc>()
                    .add(const AllTasksFetched());
                },
              ),
              child: const Icon(CupertinoIcons.add),
            ),
            appBar: BaseAppBar(
              title: localization.tasksTitle,
              action: (tasksList.isNotEmpty)
                  ? const Icon(CupertinoIcons.add_circled_solid)
                  : null,
              onPressed: (tasksList.isNotEmpty)
                  ? () => Navigator.pushNamed(context, AddTaskPage.routeName).then(
                        (_) {
                          context.read<TasksBloc>()
                            .add(const AllTasksFetched());
                        },
                      )
                  : null,
            ),
            body: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is CheckDailyGoalLoading || state is FetchHomeDataLoading) {
                  return Center(
                    child: GlobalIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (SizeConfig.heightMultiplier * 2).spaceH(),
                    const HomeGoalWidget(),
                    (SizeConfig.heightMultiplier * 2).spaceH(),
                    const HomeTaskCountWidget(),
                    (SizeConfig.heightMultiplier * 2).spaceH(),
                    const HomeTasksList(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
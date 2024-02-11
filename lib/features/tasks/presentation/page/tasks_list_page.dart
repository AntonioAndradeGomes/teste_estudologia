import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/dependency_injector.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/task_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:tasks_app/features/tasks/presentation/widgets/saved_task_modal.dart';
import 'package:tasks_app/features/tasks/presentation/widgets/task_card.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final bloc = getIt.get<TasksBloc>();

  @override
  void initState() {
    bloc.add(const GetSavedTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final entity = await showAdaptiveDialog<TaskEntity>(
            context: context,
            builder: (_) {
              return const SavedTaskModal();
            },
          );
          if (entity != null) {
            bloc.add(
              SaveTask(entity),
            );
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Minhas tarefas',
        ),
      ),
      body: BlocBuilder<TasksBloc, TasksState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is LoadingTasksState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DoneTasksState && state.tasks!.isEmpty) {
            return const Center(
              child: Text(
                textAlign: TextAlign.center,
                'Não há tarefas para mostrar',
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: state.tasks!.length,
            separatorBuilder: (_, __) {
              return const SizedBox(
                height: 10,
              );
            },
            itemBuilder: (_, index) {
              return TaskCard(
                entity: state.tasks![index],
              );
            },
          );
        },
      ),
    );
  }
}

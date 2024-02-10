import 'package:flutter/material.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/presentation/widgets/task_card.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final list = [
    TaskEntity(
      id: 1,
      content:
          'Estudar Flutter com afinco para prova técnica e uso do Bloc, Estudar Flutter com afinco para prova técnica e uso do Bloc, Estudar Flutter com afinco para prova técnica e uso do Bloc',
      description: '',
      createdAt: DateTime.now().toIso8601String(),
      taskCompletionDate: DateTime.now().toIso8601String(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Minhas tarefas',
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: list.length,
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (_, index) {
          return TaskCard(
            entity: list[index],
          );
        },
      ),
    );
  }
}

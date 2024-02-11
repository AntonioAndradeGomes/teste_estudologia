import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/common/utils/extensions.dart';
import 'package:tasks_app/dependency_injector.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/task_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/tasks_bloc.dart';

class EditTaskPage extends StatefulWidget {
  final TaskEntity taskEntity;
  const EditTaskPage({
    super.key,
    required this.taskEntity,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final bloc = getIt.get<TasksBloc>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.check_circle_rounded,
                            color: context.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 4,
                            maxLength: 250,
                            decoration: const InputDecoration(
                              hintText: 'Título da tarefa',
                              isDense: true,
                              counter: SizedBox(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return null;
                      },
                      minLines: 4,
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        isDense: true,
                        counter: SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    formatFullDate(widget.taskEntity.createdAtForDate),
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                    onPressed: () async {
                      bloc.add(RemoveTask(widget.taskEntity));
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.trash,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatFullDate(DateTime date) {
    // Formatar o nome do dia da semana
    final dayOfWeekFormat = DateFormat('EEEE', 'pt_BR');
    final dayOfWeek = dayOfWeekFormat.format(date);

    // Obter o número do dia
    final dayOfMonth = DateFormat('dd').format(date);

    // Formatar o nome do mês
    final monthFormat = DateFormat('MMMM', 'pt_BR');
    final month = monthFormat.format(date);

    // Obter o ano
    final year = DateFormat('yyyy').format(date);

    // Concatenar os componentes para formar a string completa
    return '${dayOfWeek.substring(0, 3)}., $dayOfMonth de ${month.substring(0, 3)}. de $year';
  }
}

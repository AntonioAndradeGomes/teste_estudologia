import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/common/utils/extensions.dart';
import 'package:tasks_app/dependency_injector.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/edit/task_edit_bloc.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/edit/task_edit_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/edit/task_edit_state.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/list/task_event.dart';
import 'package:tasks_app/features/tasks/presentation/bloc/list/tasks_bloc.dart';

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
  final editBloc = getIt.get<TasksEditBloc>();
  @override
  void initState() {
    editBloc.add(
      SetInitialEvent(
        widget.taskEntity.content,
        widget.taskEntity.description,
        widget.taskEntity.taskCompletionDate,
        widget.taskEntity,
      ),
    );
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
          actions: [
            IconButton(
              tooltip: 'Deletar Tarefa',
              onPressed: () async {
                bloc.add(RemoveTask(
                  widget.taskEntity,
                ));
              },
              icon: const Icon(
                FontAwesomeIcons.trash,
              ),
            ),
          ],
        ),
        body: BlocBuilder<TasksEditBloc, TaskEditState>(
          bloc: editBloc,
          builder: (context, state) {
            final isTaskCompleted = state.newtaskCompletionDate != null &&
                state.newtaskCompletionDate!.isNotEmpty;
            if (state.isNull) {
              return const SizedBox();
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                editBloc.add(
                                  EditTaskCompletionDateEvent(
                                    isTaskCompleted
                                        ? null
                                        : DateTime.now().toIso8601String(),
                                  ),
                                );
                              },
                              icon: Icon(
                                isTaskCompleted
                                    ? Icons.check_circle_rounded
                                    : Icons.radio_button_unchecked,
                                color: context.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: state.newContent,
                                onChanged: (value) {
                                  editBloc.add(EditContentEvent(value));
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Título obrigatório';
                                  }
                                  return null;
                                },
                                minLines: 1,
                                maxLines: 4,
                                maxLength: 250,
                                decoration: const InputDecoration(
                                  labelText: 'Título da tarefa',
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
                          initialValue: state.newDescription,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return null;
                          },
                          onChanged: (value) {
                            editBloc.add(EditDescriptionEvent(value));
                          },
                          minLines: 4,
                          maxLines: null,
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            isDense: true,
                            counter: SizedBox(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FilledButton.tonal(
                          onPressed: state.newContent != null &&
                                  state.newContent!.isNotEmpty
                              ? () {
                                  editBloc.add(const SubmitUpdateTask());
                                  bloc.add(const GetSavedTasks());
                                  Navigator.of(context).pop();
                                }
                              : null,
                          child: const Text(
                            'Salvar alterações',
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      'Criado em: ${formatFullDate(widget.taskEntity.createdAtForDate)}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
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

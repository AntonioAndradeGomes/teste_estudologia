import 'package:flutter/material.dart';
import 'package:tasks_app/common/utils/extensions.dart';
import 'package:tasks_app/features/tasks/domain/entities/task_entity.dart';

class SavedTaskModal extends StatefulWidget {
  const SavedTaskModal({super.key});

  @override
  State<SavedTaskModal> createState() => _SavedTaskModalState();
}

class _SavedTaskModalState extends State<SavedTaskModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      titlePadding: const EdgeInsets.all(10),
      buttonPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      titleTextStyle: context.textTheme.titleMedium,
      title: const Text(
        'Adicione uma Tarefa',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleEC,
                minLines: 1,
                maxLines: 4,
                maxLength: 250,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Título obrigatório';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Título da tarefa',
                  counter: SizedBox(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionEC,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return null;
                },
                minLines: 4,
                maxLines: null,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  counter: SizedBox(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FilledButton.tonal(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final entity = TaskEntity(
                      content: _titleEC.text.trim(),
                      description: _descriptionEC.text.trim(),
                      createdAt: DateTime.now().toIso8601String(),
                    );
                    Navigator.of(context).pop(entity);
                  }
                },
                child: const Text(
                  'Salvar Tarefa',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:tasks_app/features/tasks/data/datasources/local/dao/tasks_dao.dart';
import 'package:tasks_app/features/tasks/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [TaskModel])
abstract class AppDatabase extends FloorDatabase {
  TasksDao get taskDao;
}

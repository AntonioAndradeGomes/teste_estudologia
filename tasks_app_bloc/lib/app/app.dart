import 'package:flutter/material.dart';
import 'package:tasks_app/common/theme/app_theme.dart';
import 'package:tasks_app/features/tasks/presentation/page/tasks_list_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas tarefas',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      debugShowCheckedModeBanner: false,
      theme: AppTheme.ligth,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const TasksListPage(),
    );
  }
}

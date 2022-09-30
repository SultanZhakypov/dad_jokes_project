import 'package:dad_jokes/bloc/jokes_cubit.dart';
import 'package:dad_jokes/data/dio_settings.dart';
import 'package:dad_jokes/data/jokes_repo.dart';
import 'package:dad_jokes/joke/joke_screen.dart';
import 'package:dad_jokes/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const InitWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: JokeScreen(),
      ),
    );
  }
}

class InitWidget extends StatelessWidget {
  const InitWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => DioSettings(),
          ),
          RepositoryProvider(
            create: (context) => JokesRepository(
              dio: RepositoryProvider.of<DioSettings>(context).dio,
            ),
          ),
        ],
        child: BlocProvider(
          create: (context) =>
              JokesCubit(repo: RepositoryProvider.of<JokesRepository>(context))
                ..getJoke(),
          child: child,
        ),
      ),
    );
  }
}

import 'package:dad_jokes/data/jokes_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JokesCubit extends Cubit<JokesState> {
  JokesCubit({required this.repo}) : super(JokesInitialState());
  final JokesRepository repo;

  getJoke() async {
    try {
      final result = await repo.getJoke();
      final array = result.split('?');
      final question = '${array.first}?';
      final answer = array.last;
      emit(
        JokesSuccessState(
          question: question.trim(),
          answer: answer.trim(),
        ),
      );
    } catch (e) {
      emit(JokesErrorState());
    }
  }
}

abstract class JokesState {}

class JokesErrorState extends JokesState {}

class JokesSuccessState extends JokesState {
  final String question;
  final String answer;

  JokesSuccessState({required this.answer, required this.question});
}

class JokesInitialState extends JokesState {}

class JokesLoadingState extends JokesState {}

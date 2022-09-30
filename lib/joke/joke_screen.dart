import 'package:dad_jokes/bloc/jokes_cubit.dart';
import 'package:dad_jokes/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

part '../joke/widgets/appbar_widget.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final liquidController = LiquidController();
  final shouldShow = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const _AppBar(),
      body: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              context.watch<ThemeProvider>().bgImage,
            ),
          ),
        ),
        child: BlocConsumer<JokesCubit, JokesState>(
          listener: (context, state) {
            if (state is JokesSuccessState) {
              shouldShow.value = false;
            }
          },
          builder: (context, state) {
            if (state is JokesSuccessState) {
              return Column(
                children: [
                  const Spacer(),
                  LiquidSwipe(
                    slideIconWidget: Icon(Icons.arrow_back_ios,
                        color: context.read<ThemeProvider>().textColor),
                    slidePercentCallback:
                        (slidePercentHorizontal, slidePercentVertical) {
                      if (slidePercentHorizontal >= 100) {
                        BlocProvider.of<JokesCubit>(context).getJoke();
                      }
                    },
                    liquidController: liquidController,
                    pages: [
                      Container(
                        constraints: const BoxConstraints(minHeight: 250),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: context.watch<ThemeProvider>().bgQuestionColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 22),
                            Text(
                              'DAD JOKES',
                              style: TextStyle(
                                color: context.watch<ThemeProvider>().textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              state.question,
                              style: TextStyle(
                                color: context.watch<ThemeProvider>().textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: -1,
                              ),
                            ),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          context.read<ThemeProvider>().bgQuestionColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      shouldShow.value = true;
                    },
                    child: ValueListenableBuilder(
                        valueListenable: shouldShow,
                        builder: (context, _, __) {
                          return Text(
                            shouldShow.value ? state.answer : 'Show answer',
                            style: TextStyle(
                              color: context.watch<ThemeProvider>().textColor,
                              fontSize: 16,
                              letterSpacing: -1,
                            ),
                          );
                        }),
                  ),
                  const Spacer(),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

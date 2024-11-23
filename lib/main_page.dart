import 'package:flame/game.dart';
import 'package:flappy_dash_game/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';
import 'package:flappy_dash_game/views/game_over_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame;
  late GameCubit _gameCubit;
  PlayingState? _latestState;

  @override
  void initState() {
    _gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame = FlappyDashGame(_gameCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.currentPlayingState.isIdle &&
            (_latestState?.isGameOver ?? false)) {
          setState(() {
            _flappyDashGame = FlappyDashGame(_gameCubit);
          });
        }

        _latestState = state.currentPlayingState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _flappyDashGame),
              if (state.currentPlayingState == PlayingState.gameOver)
                const GameOverWidget(),
              if (state.currentPlayingState == PlayingState.idle)
                Align(
                  alignment: const Alignment(0, 0.3),
                  child: IgnorePointer(
                    child: const Text(
                      'TAP TO START',
                      style: TextStyle(
                        color: Color.fromARGB(255, 44, 125, 172),
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.2, 1.2),
                            duration: const Duration(milliseconds: 500)),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Flappy FreeSl',
                      style: TextStyle(
                        color: Color.fromARGB(255, 41, 132, 23),
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.3, 1),
                            duration: const Duration(milliseconds: 1000)),
                  ),
                ),
              ),
              if (state.currentPlayingState != PlayingState.gameOver)
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    state.currentScore.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 77, 73, 208),
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

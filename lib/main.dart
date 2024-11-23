import 'package:flappy_dash_game/audio_helper.dart';
import 'package:flappy_dash_game/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash_game/main_page.dart';
import 'package:flappy_dash_game/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameCubit(
        getIt.get<AudioHelper>(),
      ),
      child: const MaterialApp(
        title: 'Flappyy Dash',
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}

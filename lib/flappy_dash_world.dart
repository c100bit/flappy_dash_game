import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flappy_dash_game/audio_helper.dart';
import 'package:flappy_dash_game/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash_game/component/flappy_dash_root_component.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';
import 'package:flappy_dash_game/service_locator.dart';

class FlappyDashWorld extends World
    with TapCallbacks, HasGameRef<FlappyDashGame> {
  late FlappyDashRootComponent _rootComponent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await getIt.get<AudioHelper>().initialize();

    add(
      FlameBlocProvider<GameCubit, GameState>(
        create: () => game.gameCubit,
        children: [
          _rootComponent = FlappyDashRootComponent(),
        ],
      ),
    );
  }

  void onSpaceDown() {
    _rootComponent.onSpaceDown();
  }

  @override
  void onTapDown(TapDownEvent event) {
    _rootComponent.onTapDown(event);
  }
}

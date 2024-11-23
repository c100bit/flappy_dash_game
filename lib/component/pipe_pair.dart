import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash_game/component/hidden_coin.dart';
import 'package:flappy_dash_game/component/pipe.dart';

class PipePair extends PositionComponent
    with FlameBlocReader<GameCubit, GameState> {
  PipePair({
    required super.position,
    this.gap = 200,
    this.speed = 100.0,
  });

  final double gap;
  final double speed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll([
      Pipe(isFlipped: false, position: Vector2(0, gap / 2)),
      Pipe(isFlipped: true, position: Vector2(0, -gap / 2)),
      HiddenCoin(position: Vector2(30, 0))
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (bloc.state.currentPlayingState) {
      case PlayingState.playing:
        position.x -= speed * dt;
        break;
      case _:
    }
  }
}

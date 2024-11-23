import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash_game/component/dash.dart';
import 'package:flappy_dash_game/component/dash_background.dart';
import 'package:flappy_dash_game/component/pipe_pair.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';

class FlappyDashRootComponent extends Component
    with HasGameRef<FlappyDashGame>, FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late PipePair _lastPipe;
  static const _pipeDistance = 400.0;

  void onTapDown(TapDownEvent event) {
    _checkToStart();
    _dash.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_dash.x >= _lastPipe.x) {
      _generatePipes(fromX: _pipeDistance);
      _removePipes();
    }

    game.camera.viewfinder.zoom = 1;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(DashBackground());
    add(_dash = Dash());
    _generatePipes(fromX: 350);
  }

  void _generatePipes({
    int count = 5,
    double fromX = 0,
  }) {
    for (int i = 0; i < count; i++) {
      const area = 600;
      final y = (Random().nextDouble() * area) - area / 2;
      add(
        _lastPipe = PipePair(
          position: Vector2(fromX + (i * _pipeDistance), y),
        ),
      );
    }
  }

  void onSpaceDown() {
    _checkToStart();
    _dash.jump();
  }

  void _removePipes() {
    final pipes = children.whereType<PipePair>();
    final shouldBeRemoved = max(pipes.length - 5, 0);
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent();
    });
  }

  void _checkToStart() {
    if (bloc.state.currentPlayingState == PlayingState.idle) {
      bloc.startPlaying();
    }
  }
}

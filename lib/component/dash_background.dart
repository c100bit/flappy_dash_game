import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash_game/bloc/game/cubit/game_cubit.dart';
import 'package:flappy_dash_game/flappy_dash_game.dart';

class DashBackground extends ParallaxComponent<FlappyDashGame>
    with FlameBlocReader<GameCubit, GameState> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;

    parallax = await game.loadParallax([
      ParallaxImageData('background/layer1-sky.png'),
      ParallaxImageData('background/layer2-clouds.png'),
      ParallaxImageData('background/layer3-clouds.png'),
      ParallaxImageData('background/layer4-clouds.png'),
      ParallaxImageData('background/layer5-huge-clouds.png'),
      ParallaxImageData('background/layer6-bushes.png'),
      ParallaxImageData('background/layer7-bushes.png'),
    ], baseVelocity: Vector2(1, 0), velocityMultiplierDelta: Vector2(2, 0));
  }

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.idle:
      case PlayingState.playing:
        super.update(dt);
        break;
      case _:
    }
  }
}

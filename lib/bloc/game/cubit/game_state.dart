part of 'game_cubit.dart';

@immutable
class GameState with EquatableMixin {
  const GameState({
    this.currentScore = 0,
    this.currentPlayingState = PlayingState.idle,
  });

  final int currentScore;
  final PlayingState currentPlayingState;

  @override
  List<Object> get props => [
        currentScore,
        currentPlayingState,
      ];

  GameState copyWith({
    int? currentScore,
    PlayingState? currentPlayingState,
  }) {
    return GameState(
      currentScore: currentScore ?? this.currentScore,
      currentPlayingState: currentPlayingState ?? this.currentPlayingState,
    );
  }

  @override
  String toString() =>
      'GameState(currentScore: $currentScore, currentPlayingState: $currentPlayingState)';
}

enum PlayingState {
  idle,
  playing,
  paused,
  gameOver;

  bool get isPlaying => this == PlayingState.playing;
  bool get isGameOver => this == PlayingState.gameOver;

  bool get isIdle => this == PlayingState.idle;
  bool get isPaused => this == PlayingState.paused;
}

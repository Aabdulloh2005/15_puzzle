class PuzzleState {
  final List<int> tiles;
  final bool isCompleted;

  const PuzzleState({
    required this.tiles,
    this.isCompleted = false,
  });

  factory PuzzleState.initial() {
    List<int> initialTiles = List.generate(15, (index) => index + 1);
    initialTiles.add(0);
    initialTiles.shuffle();
    return PuzzleState(tiles: initialTiles);
  }

  PuzzleState copyWith({
    List<int>? tiles,
    bool? isCompleted,
  }) {
    return PuzzleState(
      tiles: tiles ?? this.tiles,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

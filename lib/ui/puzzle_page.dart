import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_event.dart';
import 'package:puzzle_15/blocs/puzzle_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => PuzzleBloc()..add(PuzzleInitialized()),
        child: PuzzlePage(),
      ),
    );
  }
}

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('15 Puzzle'),
      ),
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (state.isCompleted) {
            _showWinDialog(context, state.timeElapsed);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton(
                        onPressed: () {
                          context.read<PuzzleBloc>().add(PuzzleShuffled());
                        },
                        child: const Text('Restart'),
                      ),
                      Text(
                        'Time: ${state.timeElapsed}s',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return _buildTile(context, state.tiles[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTile(BuildContext context, int tile) {
    return GestureDetector(
      onTap: tile == 0
          ? null
          : () {
              context.read<PuzzleBloc>().add(TileMoved(tile));
            },
      child: Container(
        decoration: BoxDecoration(
          color: tile == 0 ? Colors.grey[300] : Colors.amber,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            tile == 0 ? '' : '$tile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: tile == 0 ? Colors.transparent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showWinDialog(BuildContext context, int timeElapsed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You completed the puzzle in $timeElapsed seconds!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

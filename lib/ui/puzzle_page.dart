import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_event.dart';
import 'package:puzzle_15/blocs/puzzle_state.dart';

class PuzzlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('15 Puzzle'),
      ),
      body: BlocBuilder<PuzzleBloc, PuzzleState>(
        builder: (context, state) {
          if (state.isCompleted) {
            showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("tugadi"),
                );
              },
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: 16,
                  itemBuilder: (context, index) {
                    return _buildTile(context, state.tiles[index]);
                  },
                ),
                const SizedBox(height: 20),
                state.isCompleted
                    ? const Text(
                        'Puzzle Completed!',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      )
                    : Container(),
              ],
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
        color: tile == 0 ? Colors.grey[300] : Colors.blue,
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
}

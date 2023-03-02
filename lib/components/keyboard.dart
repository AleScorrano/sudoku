import 'package:flutter/material.dart';
import 'package:sudoku/models/game_model.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return false
        ? SizedBox()
        : Row(
            children: List.generate(
              9,
              (index) => Expanded(
                child: InkWell(
                  onTap: () => gameModel.value.setValue(index + 1),
                  splashColor: Colors.purple.shade300,
                  borderRadius: BorderRadius.circular(30),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

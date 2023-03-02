import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/models/game_model.dart';

class Timer extends StatelessWidget {
  const Timer({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => gameModel.value.completed
        ? Text(
            " GIOCO FINITO (${gameModel.value.timeFormatted})",
            style: TextStyle(
                color: gameModel.value.correct ? Colors.green : Colors.red,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          )
        : Text(
            "(${gameModel.value.timeFormatted})",
            style: TextStyle(
                color: Colors.grey.shade600,
                letterSpacing: 2,
                fontWeight: FontWeight.bold),
          ));
  }
}

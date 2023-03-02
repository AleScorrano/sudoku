import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_solver_generator/sudoku_solver_generator.dart';

final gameModel = GameModel().obs;

class GameModel {
  late List<List<CellModel>> board;
  late List<List<CellModel>> boardSolved;
  late CellModel cellInFocus;
  late DateTime startDate;
  late DateTime currentDate;
  List<String> difficults = <String>["Easy", "Medium", "Hard"];
  String initialDifficult = "Medium";
  int epmtysquares = 20;

  GameModel() {
    newGame();
  }

  void newGame() {
    final sudokuGenerator = SudokuGenerator(emptySquares: epmtysquares);
    SudokuUtilities.printSudoku(sudokuGenerator.newSudoku);

    board = [0, 1, 2, 3, 4, 5, 6, 7, 8].map((quadrantIndex) {
      return [0, 1, 2, 3, 4, 5, 6, 7, 8].map((cellIndex) {
        final row = (cellIndex ~/ 3) + (quadrantIndex ~/ 3 * 3);
        final column = (cellIndex % 3) + (quadrantIndex % 3 * 3);
        int cellValue = sudokuGenerator.newSudoku[row][column];

        return CellModel(
          value: cellValue,
          editable: cellValue == 0,
        );
      }).toList();
    }).toList();

    boardSolved = [0, 1, 2, 3, 4, 5, 6, 7, 8].map((quadrantIndex) {
      return [0, 1, 2, 3, 4, 5, 6, 7, 8].map((cellIndex) {
        final row = (cellIndex ~/ 3) + (quadrantIndex ~/ 3 * 3);
        final column = (cellIndex % 3) + (quadrantIndex % 3 * 3);
        int cellValue = sudokuGenerator.newSudokuSolved[row][column];

        return CellModel(
          value: cellValue,
          editable: cellValue == 0,
        );
      }).toList();
    }).toList();

    cellInFocus = board
        .firstWhere(
            (quadrant) => quadrant.any((cellModel) => cellModel.value == 0))
        .firstWhere((cellModel) => cellModel.value == 0);

    startDate = DateTime.now();
    currentDate = DateTime.now();

    _startTimer();
  }

  void setDifficult(String value) {
    gameModel.value.initialDifficult = value;
    switch (gameModel.value.initialDifficult) {
      case "Easy":
        {
          epmtysquares = 10;
        }
        break;
      case "Medium":
        {
          epmtysquares = 20;
        }
        break;
      case "Hard":
        {
          epmtysquares = 28;
        }
        break;
    }
    gameModel.refresh();
  }

  void _startTimer() async {
    if (!completed) {
      await Future.delayed(Duration(seconds: 1));
      currentDate = DateTime.now();
      gameModel.refresh();
      _startTimer();
    }
  }

  void focusCell(CellModel cellModel) {
    if (cellModel.editable) {
      cellInFocus = cellModel;
      gameModel.refresh();
    }
  }

  void setValue(int value) {
    if (!completed) {
      cellInFocus.value = value;
      gameModel.refresh();
    }
  }

  bool isCellInFocus(CellModel cellModel) {
    return cellInFocus == cellModel;
  }

  bool get completed {
    return board.every((quadrantModel) =>
        quadrantModel.every((cellModel) => cellModel.value != 0));
  }

  bool get correct {
    final boardValues = board
        .expand((quadrantModel) =>
            quadrantModel.expand((cellModel) => [cellModel.value]))
        .toList();

    final boardSolvedValues = boardSolved
        .expand((quadrantModel) =>
            quadrantModel.expand((cellModel) => [cellModel.value]))
        .toList();
    print("boardvalues ${boardValues}");
    print("soluzione ${boardSolvedValues}");
    return listEquals(boardValues, boardSolvedValues);
  }

  String get timeFormatted {
    final dateDifference = currentDate.difference(startDate);
    final minutes = dateDifference.inMinutes.remainder(60);
    final seconds = dateDifference.inSeconds.remainder(60);
    return "${minutes < 10 ? '0' : ""}$minutes:${seconds < 10 ? '0' : ""}$seconds";
  }
}

class CellModel {
  int value;
  bool editable;
  CellModel({required this.value, required this.editable});
}

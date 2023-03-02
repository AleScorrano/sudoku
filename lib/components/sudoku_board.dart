import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/models/game_model.dart';

class SudokuBoard extends StatelessWidget {
  const SudokuBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => (Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              color: Colors.grey.shade300,
              width: double.infinity,
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: gameModel.value.board.length,
                padding: EdgeInsets.all(0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  crossAxisCount: 3,
                ),
                itemBuilder: ((context, quadrantindex) => SudokuQuadrant(
                    cells: gameModel.value.board[quadrantindex])),
              ),
            ),
          ))),
    );
  }
}

class SudokuQuadrant extends StatelessWidget {
  final List<CellModel> cells;
  SudokuQuadrant({required this.cells});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: GridView.builder(
          padding: EdgeInsets.all(6),
          itemCount: cells.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              crossAxisCount: 3),
          itemBuilder: ((context, cellindex) => SudokuCell(
                cellModel: cells[cellindex],
              )),
        ));
  }
}

class SudokuCell extends StatelessWidget {
  final CellModel cellModel;
  const SudokuCell({required this.cellModel});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (GestureDetector(
        onTap: () => gameModel.value.focusCell(cellModel),
        child: Container(
          child: Center(
            child: Text(
              cellModel.value == 0 ? "" : cellModel.value.toString(),
              style: TextStyle(
                  fontSize: 18,
                  color: cellModel.editable
                      ? Colors.purple.shade900
                      : Colors.grey.shade700,
                  fontWeight:
                      cellModel.editable ? FontWeight.bold : FontWeight.w600),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
            boxShadow: gameModel.value.isCellInFocus(cellModel)
                ? [
                    BoxShadow(
                      color: Colors.purple,
                      blurRadius: 2,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.purple.shade800,
                      blurRadius: 4,
                      spreadRadius: 0,
                    )
                  ]
                : [],
          ),
        ),
      )),
    );
  }
}

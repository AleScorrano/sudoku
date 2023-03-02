import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku/components/keyboard.dart';
import 'package:sudoku/components/sudoku_board.dart';
import 'package:sudoku/components/timer.dart';
import 'package:sudoku/models/game_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.purple.shade100,
        elevation: 2,
        title: Text(
          "SUDOKU",
          style: TextStyle(
            letterSpacing: 2,
            color: Colors.deepPurple,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              gameModel.value.newGame();
              gameModel.refresh();
            },
            icon: Icon(
              Icons.restart_alt,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      );
  Widget body() => Column(
        children: [
          SetDifficult(),
          Divider(
            thickness: 2,
          ),
          SudokuBoard(),
          SizedBox(height: 10),
          Timer(),
          SizedBox(height: 32),
          Keyboard(),
        ],
      );

  Widget SetDifficult() => Obx(() => Padding(
        padding: EdgeInsets.fromLTRB(25, 10, 20, 0),
        child: Row(
          children: [
            Center(
              child: Text(
                "difficoltà:",
                style: TextStyle(
                    letterSpacing: 2,
                    color: Colors.deepPurpleAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: DropdownButton<String>(
                alignment: AlignmentDirectional.bottomStart,
                borderRadius: BorderRadius.circular(16),
                dropdownColor: Colors.grey.shade200,
                iconEnabledColor: Colors.purple.shade500,
                //isExpanded: true,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
                icon: Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  size: 28,
                ),
                value: gameModel.value.initialDifficult,
                items: gameModel.value.difficults
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(child: Text(value)),
                  );
                }).toList(),
                onChanged: (value) => gameModel.value.setDifficult(value!),
              ),
            ),
          ],
        ),
      ));
}

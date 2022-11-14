import 'dart:math';
import 'package:flutter/material.dart';

// from https://www.geeksforgeeks.org/minimax-algorithm-in-game-theory-set-3-tic-tac-toe-ai-finding-optimal-move/

class IAalgo {
  static const String PLAYER_X = "X";
  static const String PLAYER_O =
      "O"; // This is the evaluation function as discussed
  // in the previous article ( http://goo.gl/sJgv68 )
  static int evaluate(List<String>? b) {
    // Checking for Rows for X or O victory.
    for (int row = 0; row < 3; row++) {
      if (b![(row * 3) + 0] == b![(row * 3) + 1] &&
          b![(row * 3) + 1] == b![(row * 3) + 2]) {
        if (b[(row * 3) + 0] == PLAYER_O)
          return 10;
        else if (b[(row * 3) + 0] == PLAYER_X) return -10;
      }
    }

    // Checking for Columns for X or O victory.
    for (int col = 0; col < 3; col++) {
      if (b![0 + col] == b![3 + col] && b![3 + col] == b![6 + col]) {
        if (b[0 + col] == PLAYER_O)
          return 10;
        else if (b[0 + col] == PLAYER_X) return -10;
      }
    }

    // Checking for Diagonals for X or O victory.
    if (b![0] == b![4] && b![4] == b![8]) {
      if (b![0] == PLAYER_O)
        return 10;
      else if (b[0] == PLAYER_X) return -10;
    }

    if (b[2] == b[4] && b[4] == b[6]) {
      if (b[2] == PLAYER_O)
        return 10;
      else if (b[2] == PLAYER_X) return -10;
    }

    // Else if none of them have won then return 0
    return 0;
  }

  // This is the minimax function. It considers all
  // the possible ways the game can go and returns
  // the value of the board
  static int minimax(List<String>? board, int depth, bool isMax) {
    int score = evaluate(board);

    // If Maximizer has won the game
    // return his/her evaluated score
    if (score == 10) return score;

    // If Minimizer has won the game
    // return his/her evaluated score
    if (score == -10) return score;

    // If there are no more moves and
    // no winner then it is a tie
    //if (Game.avableFreeBoxes(board) == 0) return 0;

    // If this maximizer's move
    if (isMax) {
      int best = -1000;

      // Traverse all cells
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          // Check if cell is empty
          if (board![(i * 3) + j] == "") {
            // Make the move
            board![(i * 3) + j] = PLAYER_O;

            // Call minimax recursively and choose
            // the maximum value
            best = max(best, minimax(board, depth + 1, !isMax));

            // Undo the move
            board![(i * 3) + j] = "";
          }
        }
      }
      return best;
    }

    // If this minimizer's move
    else {
      int best = 1000;

      // Traverse all cells
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          // Check if cell is empty
          if (board![(i * 3) + j] == "") {
            // Make the move
            board![(i * 3) + j] = PLAYER_X;

            // Call minimax recursively and choose
            // the minimum value
            best = min(best, minimax(board, depth + 1, !isMax));

            // Undo the move
            board![(i * 3) + j] = "";
          }
        }
      }
      return best;
    }
  }

  // This will return the best possible
  // move for the player
  static int findBestMove(List<String>? board) {
    int bestVal = -1000;
    var bestMove = {'row': 0, 'col': 0};
    bestMove['row'] = -1;
    bestMove['col'] = -1;

    // Traverse all cells, evaluate minimax function
    // for all empty cells. And return the cell
    // with optimal value.
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        // Check if cell is empty
        if (board![(i * 3) + j] == "") {
          // Make the move
          board![(i * 3) + j] = PLAYER_O;

          // compute evaluation function for this
          // move.
          int moveVal = minimax(board, 0, false);

          // Undo the move
          board![(i * 3) + j] = "";

          // If the value of the current move is
          // more than the best value, then update
          // best/
          if (moveVal > bestVal) {
            bestMove['row'] = i;
            bestMove['col'] = j;
            bestVal = moveVal;
          }
        }
      }
    }

    //print(bestMove);

    return (bestMove['row']! * 3) +
        bestMove['col']!; //((bestMove['row']*3) + bestMove['row'])
  }
}

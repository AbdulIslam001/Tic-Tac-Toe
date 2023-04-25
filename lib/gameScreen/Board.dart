import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/gameScreen/resultScreen.dart';
import 'package:tic_tac_toe_game/profile.dart';

import '../Offline/SelectGameMode.dart';

class BoardBoxes extends StatefulWidget {
 final String crossaxiscount,title;
  const BoardBoxes({Key? key,required this.crossaxiscount,required this.title}):super(key: key);
  @override
  _BoardBoxesState createState() => _BoardBoxesState();
}
class _BoardBoxesState extends State<BoardBoxes> {
  late final List<List<String>> _board;
  int tap = 0;
  String winner = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _board = List.generate(int.parse(widget.crossaxiscount), (index) =>
        List.filled(int.parse(widget.crossaxiscount), ''));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Are you sure you want to exit game?"),
              actions: <Widget>[
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const SelectGameMode();
                      }));
                }, child: const Text("yes", style: TextStyle(color: Colors
                    .black, fontWeight: FontWeight.bold, fontSize: 20),)),
              ],
            );
          });
        }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:
        Text(widget.title, style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 25,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width / 45,
              ),
              Column(
                children: [
                  const Text("You"),
                  Container(
                    width: size.width / 5,
                    height: size.height / 10,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(child: Text("O",
                        style: TextStyle(color: Colors.red, fontSize: 40))),
                  ),
//                  Stream.periodic(Duration(seconds: 1),(int count){})
                ],
              ),
              SizedBox(
                width: size.width * 0.54,
                child: Center(child: Text(winner)),
              ),
              Column(
                children: [
                  const Text("Opponent"),
                  Container(
                    width: size.width / 5,
                    height: size.height / 10,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(child: Text("X",
                        style: TextStyle(color: Colors.red, fontSize: 40))),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: int.parse(widget.crossaxiscount),
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: int.parse(widget.crossaxiscount) *
                int.parse(widget.crossaxiscount),
            //int.parse(widget.IC)
            itemBuilder: (BuildContext context, int index) {
              int row = index ~/ int.parse(widget.crossaxiscount);
              int col = index % int.parse(widget.crossaxiscount);
              return GestureDetector(
                onTap: () => _handleTap(row, col),
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(_board[row][col], style: const TextStyle(
                        fontSize: 35, color: Colors.white)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _handleTap(int row, int col) {
    if (tap % 2 == 0) {
      if (_board[row][col] == '') {
        setState(() {
          _board[row][col] = 'O';
        });
      } else {
        setState(() {
          tap = 1;
        });
      }
    } else {
      if (_board[row][col] == '') {
        setState(() {
          _board[row][col] = 'X';
        });
      } else {
        setState(() {
          tap = 2;
        });
      }
    }
    if (widget.title == '3x3') {
      checkWinner3x3();
    } else if (widget.title == '6x6') {
      checkForWin6x6();
      // checkWinner6x6();
    } else if (widget.title == '9x9') {
   //   checkWinner9x9();
      checkForWin9x9();
    }
    tap++;
  }

  checkWinner3x3() {
    gamePlayed++;
    //Row
    for (int i = 0; i < 3; i++) {
      if (_board[i][0] != '') {
        if (_board[i][0] == _board[i][1] && _board[i][1] == _board[i][2]) {
          if (_board[i][0] == 'X') {
            winner = 'Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            gameWon++;
            winner = 'You Rocked! you won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    //Column
    for (int j = 0; j < 3; j++) {
      if (_board[0][j] != '') {
        if (_board[0][j] == _board[1][j] && _board[1][j] == _board[2][j]) {
          if (_board[0][j] == 'X') {
            winner = 'Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            gameWon++;
            winner = 'You Rocked! you won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }
//Dialgonal
    if (_board[0][0] != '' && _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2]) {
      if (_board[0][0] == 'X') {
        winner = 'Opponent have won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      } else {
        gameWon++;
        winner = 'You Rock! you won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      }
    } else if (_board[0][2] != '' && _board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0]) {
      if (_board[0][2] == 'X') {
        winner = 'Opponent have won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      } else {
        gameWon++;
        winner = 'You Rock! you won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      }
    }
  }

  checkWinner6x6() {
    gamePlayed++;
    //Row
    for (int i = 0; i < 6; i++) {
      if (_board[i][0] != '') {
        if (_board[i][0] == _board[i][1] && _board[i][1] == _board[i][2] &&
            _board[i][2] == _board[i][3] && _board[i][3] == _board[i][4] &&
            _board[i][4] == _board[i][5]) {
          if (_board[i][0] == 'X') {
            winner = 'Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            gameWon++;
            winner = 'You Rocked! you won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    //Column
    for (int j = 0; j < 6; j++) {
      if (_board[0][j] != '') {
        if (_board[0][j] == _board[1][j] && _board[1][j] == _board[2][j] &&
            _board[2][j] == _board[3][j] && _board[3][j] == _board[4][j] &&
            _board[4][j] == _board[5][j]) {
          if (_board[0][j] == 'X') {
            winner = 'Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            gameWon++;
            winner = 'You Rocked! you won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }
//Dialgonal
    if (_board[0][0] != '' && _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] && _board[2][2] == _board[3][3] &&
        _board[3][3] == _board[4][4] && _board[4][4] == _board[5][5]) {
      if (_board[0][0] == 'X') {
        winner = 'Opponent have won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      } else {
        gameWon++;
        winner = 'You Rock! you won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      }
    } else if (_board[0][5] != '' && _board[0][5] == _board[1][4] &&
        _board[1][4] == _board[2][3] && _board[2][3] == _board[3][2] &&
        _board[3][2] == _board[4][1] && _board[4][1] == _board[5][0]) {
      if (_board[0][5] == 'X') {
        winner = 'Opponent have won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      } else {
        gameWon++;
        winner = 'You Rock! you won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      }
    }
  }

  checkWinner9x9() {
    gamePlayed++;
    //Row
    for (int i = 0; i < 9; i++) {
      if (_board[i][0] != '') {
        if (_board[i][0] == _board[i][1] && _board[i][1] == _board[i][2] &&
            _board[i][2] == _board[i][3] && _board[i][3] == _board[i][4] &&
            _board[i][4] == _board[i][5] && _board[i][5] == _board[i][6] &&
            _board[i][6] == _board[i][7] && _board[i][7] == _board[i][8]) {
          if (_board[i][0] == 'X') {
            winner = 'Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            gameWon++;
            winner = 'You Rocked! you won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    //Column
    for (int j = 0; j < 9; j++) {
      if (_board[0][j] != '') {
        if (_board[0][j] == _board[1][j] && _board[1][j] == _board[2][j] &&
            _board[2][j] == _board[3][j] && _board[3][j] == _board[4][j] &&
            _board[4][j] == _board[5][j] && _board[5][j] == _board[6][j] &&
            _board[6][j] == _board[7][j] && _board[7][j] == _board[8][j]) {
          if (_board[0][j] == 'X') {
            winner = 'Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            gameWon++;
            winner = 'You Rocked! you won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }
//Dialgonal
    if (_board[0][0] != '' && _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2] && _board[2][2] == _board[3][3] &&
        _board[3][3] == _board[4][4] && _board[4][4] == _board[5][5] &&
        _board[5][5] == _board[6][6] && _board[6][6] == _board[7][7] &&
        _board[7][7] == _board[8][8]) {
      if (_board[0][0] == 'X') {
        winner = 'Opponent have won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      } else {
        gameWon++;
        winner = 'You Rock! you won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      }
    }
    else if (_board[0][8] != '' && _board[0][8] == _board[1][7] &&
        _board[1][7] == _board[2][6] && _board[2][6] == _board[3][5] &&
        _board[3][5] == _board[4][4] && _board[4][4] == _board[5][3] &&
        _board[5][3] == _board[6][2] && _board[6][2] == _board[7][1] &&
        _board[7][1] == _board[8][0]) {
      if (_board[0][5] == 'X') {
        winner = 'Opponent have won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      } else {
        gameWon++;
        winner = 'You Rock! you won';
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return resultScreen(result: winner);
            }));
      }
    }
  }

  checkForWin6x6() {
    // Check rows
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] != "" &&
            _board[i][j] == _board[i][j + 1] &&
            _board[i][j] == _board[i][j + 2] &&
            _board[i][j] == _board[i][j + 3]) {
          if (_board[i][j] == 'X') {
            winner = 'Opponent have Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            winner = 'You Rocked! You Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    // Check columns
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[j][i] != "" &&
            _board[j][i] == _board[j + 1][i] &&
            _board[j][i] == _board[j + 2][i] &&
            _board[j][i] == _board[j + 3][i]) {
          if (_board[j][i] == 'X') {
            winner = 'Opponent have Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            winner = 'You Rocked! You Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    // Check diagonals (top-left to bottom-right)
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (_board[i][j] != "" &&
            _board[i][j] == _board[i + 1][j + 1] &&
            _board[i][j] == _board[i + 2][j + 2] &&
            _board[i][j] == _board[i + 3][j + 3]) {
          if (_board[i][j] == 'X') {
            winner = 'Opponent have Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            winner = 'You Rocked! You Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    // Check diagonals (top-right to bottom-left)
    for (int row = 0; row < 3; row++) {
      for (int col = 3; col < 6; col++) {
        if (_board[row][col] != "" &&
            _board[row][col] == _board[row + 1][col - 1] &&
            _board[row][col] == _board[row + 2][col - 2] &&
            _board[row][col] == _board[row + 3][col - 3]) {
          if (_board[row][col] == 'X') {
            winner = 'Opponent have Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          } else {
            winner = 'You Rocked! You Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }
  }
  checkForWin9x9() {
    // Check rows
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 2; j++) {
        if (_board[i][j] != "" &&
            _board[i][j] == _board[i][j + 1] &&
            _board[i][j] == _board[i][j + 2] &&
            _board[i][j] == _board[i][j + 3] &&
            _board[i][j] == _board[i][j + 4]) {
          if(_board[i][j] =='X'){
            winner='Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }else{
            winner='You Rocked! you Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    // Check columns
    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 2; j++) {
        if (_board[j][i] != "" &&
            _board[j][i] == _board[j + 1][i] &&
            _board[j][i] == _board[j + 2][i] &&
            _board[j][i] == _board[j + 3][i] &&
            _board[j][i] == _board[j + 4][i]) {
          if(_board[j][i] =='X'){
            winner='Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }else{
            winner='You Rocked! you Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    // Check diagonals (top-left to bottom-right)
    for (int i = 0; i < 2; i++) {
      for (int j = 0; j < 2; j++) {
        if (_board[i][j] != "" &&
            _board[i][j] == _board[i + 1][j + 1] &&
            _board[i][j] == _board[i + 2][j + 2] &&
            _board[i][j] == _board[i + 3][j + 3] &&
            _board[i][j] == _board[i + 4][j + 4]) {
          if(_board[i][j] =='X'){
            winner='Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }else{
            winner='You Rocked! you Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }

    // Check diagonals (top-right to bottom-left)
    for (int i = 0; i < 2; i++) {
      for (int j = 4; j < 6; j++) {
        if (_board[i][j] != "" &&
            _board[i][j] == _board[i + 1][j - 1] &&
            _board[i][j] == _board[i + 2][j - 2] &&
            _board[i][j] == _board[i + 3][j - 3]) {
          if(_board[i][j] =='X'){
            winner='Opponent have won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }else{
            winner='You Rocked! you Won';
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return resultScreen(result: winner);
                }));
          }
        }
      }
    }
  }
}
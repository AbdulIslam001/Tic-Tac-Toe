import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/gameScreen/resultScreen.dart';
import '../Offline/SelectGameMode.dart';

class OnlineBoardBoxes extends StatefulWidget {
  final String crossaxiscount,symbol;
  final String ip;
  final Socket socket;
  const OnlineBoardBoxes({Key? key,required this.crossaxiscount,required this.symbol,required this.ip,required this.socket}):super(key: key);
  @override
  _OnlineBoardBoxesState createState() => _OnlineBoardBoxesState();
}
class _OnlineBoardBoxesState extends State<OnlineBoardBoxes> {
  late List<List<String>> _board;
  String winner = '';
  late List<List<String>> receivedData;
  GlobalKey<State> waitingDialogKey = GlobalKey<State>();
  @override

  BuildContext? waitingDialogContext;

  void showWaitingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        waitingDialogContext = context; // Store the context
        return const AlertDialog(
          title: Text('Waiting for another player'),
          content: Text('Please wait until the next player joins.'),
        );
      },
    );
  }

  void secondPlayerJoined() {
    if (waitingDialogContext != null) {
      Navigator.pop(waitingDialogContext!);
    }
  }

  @override
  void initState() {
    //print(id);
    // TODO: implement initState
    super.initState();
    _board = List.generate(int.parse(widget.crossaxiscount), (index) =>
        List.filled(int.parse(widget.crossaxiscount), ''));
  }
 late int id;
String you='X';
String opponent='O';
  @override
  Widget build(BuildContext context) {
    String receivedId=widget.symbol;
    if(receivedId=='0'){
      setState(() {
        print(widget.symbol);
        id=int.parse(widget.symbol);
        you='O';
        opponent='X';
      });
    //  showWaitingDialog(context);
    }else{
      setState(() {
        id=1;
        opponent='O';
        you='X';
      });
   //   secondPlayerJoined();
    }
    receivedId='';
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Are receivedId sure receivedId want to exit game?"),
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
        const Text("6x6", style:TextStyle(
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
                    child:Center(child: Text(you,
                        style: const TextStyle(color: Colors.red, fontSize: 40))),
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
                    child: Center(child: Text(opponent,
                        style: const TextStyle(color: Colors.red, fontSize: 40))),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Expanded(
            child: GridView.builder(
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
                String data=_board[row][col];
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      _handleTap(row, col);
                    });
                  },
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
          ),
        ],
      ),
    );
  }
/*  void receiveDataFromServer(){
    widget.socket?.listen((List<int> data) {
      receivedData = String.fromCharCodes(data);
      // Handle received string data
      print(receivedData);
    },
    );
  }*/
  /*void sendDataToServer( list) async {
    String data=jsonEncode(list);
    widget.socket.write(data);
  }*/
  void _handleTap(int row, int col) {
    print(_board);
    print(row);
    print(col);
    if(_board[row][col]=='' && id==0){
        setState(() {
          _board[row][col]=you.toString();
        });
    }else if(_board[row][col]==''){
      if(id==1){
        setState(() {
          _board[row][col]=you.toString();
        });
      }
    }
    Map<String, dynamic> msg = {
      'list': _board,
      'Id': id,
    };

    String json = jsonEncode(msg);
    widget.socket.write(json.toString());
    checkForWin6x6();
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
            winner = 'You Won';
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
  void receiveDataFromServer(){
    widget.socket.listen((List<int> data) {
      String jsonString = utf8.decode(data);
      receivedData = jsonDecode(jsonString);
      setState(() {
      _board.addAll(receivedData);
      });
    },
    );
  }
}
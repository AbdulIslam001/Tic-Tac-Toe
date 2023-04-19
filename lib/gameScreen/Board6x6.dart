import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/gameScreen/SelectGameMode.dart';

class TicTacToeBoard6x6 extends StatefulWidget {
  @override
  _TicTacToeBoard6x6State createState() => _TicTacToeBoard6x6State();
}
class _TicTacToeBoard6x6State extends State<TicTacToeBoard6x6> {
  final List<List<String>> _board =
  List.generate(6, (_) => List.filled(6, ''));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:IconButton(onPressed: (){
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: Colors.white,
              title:const Text("Are you sure you want to exit game?"),
              actions: <Widget>[
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return const SelectGameMode();
                  }));
                }, child:const Text("yes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
              ],
            );
          });
        }, icon:const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:
      const Text("6x6 Board",
      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),elevation: 0,
        backgroundColor: Colors.black,
      ) ,
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 36,
          itemBuilder: (BuildContext context, int index) {
            int row = index ~/ 6;
            int col = index % 6;
            return GestureDetector(
              onTap: () => _handleTap(row, col),
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Text(_board[row][col],style:const TextStyle(fontSize: 15,color: Colors.white)),
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
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = 'X';
      });
    }
  }
}

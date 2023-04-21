import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/SinglePlayer/SelectGameMode.dart';

class BoardBoxes extends StatefulWidget {
 final String crossaxiscount,title;
  const BoardBoxes({Key? key,required this.crossaxiscount,required this.title}):super(key: key);
  @override
  _BoardBoxesState createState() => _BoardBoxesState();
}
class _BoardBoxesState extends State<BoardBoxes> {
  late final List<List<String>> _board;
  int tap=0;
  String winner='';
  late StreamSubscription timer;
  checkWinner(){
    for(int i=0;i<3;i++){
      if(_board[i][0]!=''){
        if(_board[i][0]==_board[i][1] &&_board[i][1]==_board[i][2]){
          if(_board[i][0]=='X'){
            winner='Opponent have won';
          }else{
            winner='You Rocked! you won';
          }
        }
      }
    }
    for(int j=0;j<3;j++){

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _board=List.generate(int.parse(widget.crossaxiscount), (index) => List.filled(int.parse(widget.crossaxiscount),''));

  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
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
        Text(widget.title, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),elevation: 0,
        backgroundColor: Colors.black,
      ) ,
      body: Column(
        children: [
           SizedBox(
            height: size.height/25,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width/45,
              ),
              Column(
                children: [
                  const Text("You"),
                  Container(
                    width:size.width/5,
                    height: size.height/10,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:const Center(child: Text("O",style: TextStyle(color: Colors.red,fontSize: 40))),
                  ),
//                  Stream.periodic(Duration(seconds: 1),(int count){})
                ],
              ),
              SizedBox(
                  width:size.width*0.54,
                child: Center(child: Text(winner)),
               ),
                Column(
                  children: [
                    const Text("Opponent"),
                    Container(
                      width:size.width/5,
                      height: size.height/10,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:const Center(child: Text("X",style: TextStyle(color: Colors.red,fontSize: 40))),
                    ),
                  ],
                )
            ],
          ),
          SizedBox(
            height: size.height*0.02,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: int.parse(widget.crossaxiscount),
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount:int.parse(widget.crossaxiscount)*int.parse(widget.crossaxiscount) ,
            //int.parse(widget.IC)
            itemBuilder: (BuildContext context, int index) {
              int row = index ~/ int.parse(widget.crossaxiscount);
              int col = index % int.parse(widget.crossaxiscount);
              return GestureDetector(
                onTap: () => _handleTap(row, col),
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Text(_board[row][col],style:const TextStyle(fontSize: 35,color: Colors.white)),
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
    tap++;
    if(tap%2==0){
      if (_board[row][col] == '') {
        setState(() {
          _board[row][col] = 'X';
        });
      }
      // if(_board[0][0]=='X' &&_board[1][1]=='X' && _board[2][2]=='X' || _board[0][1]=='X' &&_board[1][0]=='X' && _board[2][0]=='X'||_board[0][0]=='X' &&_board[0][1]=='X' && _board[0][2]=='X'){
      //   winner="Opponent Won";
      //}
    }else{
      if (_board[row][col] == '') {
        setState(() {
          _board[row][col] = 'O';
        });
      }
      // if(_board[0][0]=='O' &&_board[1][1]=='O' && _board[2][2]=='O' || _board[0][1]=='O' &&_board[1][0]=='O' && _board[2][0]=='O'||_board[0][0]=='O' &&_board[0][1]=='O' && _board[0][2]=='O'){
      //   winner="You Rocked! you won";
      //}
    }
    checkWinner();
  }
}
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/SinglePlayer/SelectGameMode.dart';

class BoardBoxes extends StatefulWidget {
 final String itemcount,crossaxiscount,title;
  const BoardBoxes({Key? key,required this.crossaxiscount,required this.itemcount,required this.title}):super(key: key);
  @override
  _BoardBoxesState createState() => _BoardBoxesState();
}
class _BoardBoxesState extends State<BoardBoxes> {
  late final List<List<String>> _board;
  int tap=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _board=List.generate(int.parse(widget.crossaxiscount), (index) => List.filled(int.parse(widget.crossaxiscount),''));

  }
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
        Text(widget.title, style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30)),elevation: 0,
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
    }else{
      if (_board[row][col] == '') {
        setState(() {
          _board[row][col] = 'O';
        });
      }
    }
  }
}

//  const Board({required Key key,required this.itemcount,required}):super(key: key);
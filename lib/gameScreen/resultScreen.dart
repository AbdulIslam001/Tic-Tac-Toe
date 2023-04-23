import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe_game/Offline/SelectGameMode.dart';
import 'package:tic_tac_toe_game/gameScreen/gameEnterenceScreen.dart';

import '../imagesString.dart';

class resultScreen extends StatelessWidget {
  String result;
  resultScreen({Key? key,required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children:[
            const Image(image: AssetImage(icon)),
            Text(result,style:const TextStyle(color: Colors.black,fontSize: 35,fontWeight: FontWeight.bold),),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const SelectGameMode();
                        }));
                  }, icon:const Icon(Icons.play_arrow_rounded,color: Colors.teal,size: 70)),
                  IconButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const GameEntranceScreen();
                        }));
                  }, icon:const Icon(Icons.home,color: Colors.teal,size: 70)),
                  IconButton(onPressed: (){
                    SystemNavigator.pop();
                  }, icon:const Icon(Icons.exit_to_app,color: Colors.teal,size: 70)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

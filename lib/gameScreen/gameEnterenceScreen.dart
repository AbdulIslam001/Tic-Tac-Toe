import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/gameScreen/SelectGameMode.dart';

import '../cutomWidget/Button.dart';
import '../imagesString.dart';
class GameEntranceScreen extends StatefulWidget {
  const GameEntranceScreen({Key? key}) : super(key: key);

  @override
  State<GameEntranceScreen> createState() => _GameEntranceScreenState();
}
bool _loading=false;
bool _loading1=false;
class _GameEntranceScreenState extends State<GameEntranceScreen> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions:[
          CircleAvatar(
            backgroundColor: Colors.transparent,
           // radius:40,
            child: GestureDetector(
                onTap: (){
                  showDialog(context: context, builder: (BuildContext context){
                    return  AlertDialog(
                      elevation: 0,
                      backgroundColor: Colors.orangeAccent,
                      title:const Center(child: Text("Player Profile",)),
                      actions: [
                        TextFormField(
                          decoration:const InputDecoration(
                            fillColor: Colors.white,
                            hintText: "Player",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.white)
                            )
                          ),
                        ),
                      ],
                    );
                  });
                },
                child:const Icon(Icons.person_pin,size: 40)),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(100, 23, 45, 4),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: size.height*0.07,
          // ),
          Container(
            height:size.height*0.2,
            width:size.width*1,
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ttt),
                fit: BoxFit.fill
              )
            ),
          ),
          Container(
            height:size.height*0.3,
            width:size.width*1,
            decoration:const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(MSIMG),
                  fit: BoxFit.fill
                )
            ),
          ),
          SizedBox(
            height: size.height*0.05,
          ),
          Button(icon: Icons.person,  title:"Singleplayer",loading: _loading,ontap:(){
            setState(() {
              _loading=true;
            });
            Future.delayed(const Duration(seconds: 2),() {
              Navigator.push(context,MaterialPageRoute(builder: (context){
                return const SelectGameMode();
              }));
              setState(() {
                _loading=false;
              });
            },);
          },),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.03
          ),
          Button( icon: Icons.person_add_alt_1_rounded,title:"Multiplayers",loading:_loading1,ontap:(){},),
          SizedBox(
              height: MediaQuery.of(context).size.height*0.03
          ),
          Button( icon: Icons.leaderboard,title:"LeaderBoard",loading:_loading1,ontap:(){},)
        ],
      ),
    );
  }
}

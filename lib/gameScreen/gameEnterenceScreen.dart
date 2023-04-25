import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/Online/SelectMode.dart';
import 'package:tic_tac_toe_game/profile.dart';

import '../Offline/SelectGameMode.dart';
import '../cutomWidget/Button.dart';
import '../imagesString.dart';
class GameEntranceScreen extends StatefulWidget {
  const GameEntranceScreen({Key? key}) : super(key: key);

  @override
  State<GameEntranceScreen> createState() => _GameEntranceScreenState();
}
TextEditingController _name=TextEditingController();
bool _loading=false;
bool _loading1=false;
bool _loading2=false;
String hintText='Player 1';
class _GameEntranceScreenState extends State<GameEntranceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
                      scrollable: true,
                      elevation: 0,
                      backgroundColor: Colors.orangeAccent,
                      title:const Center(child: Text("Player Profile",)),
                      actions: [
                        TextFormField(
                          decoration:const InputDecoration(
                              fillColor: Colors.white,
                              hintText:'Player',
                              border: OutlineInputBorder(
                               borderSide: BorderSide.none
                              )
                          ),
                          controller: _name,
                          onEditingComplete: () {
                            hintText=_name.toString();
                          },
                        ),
                        Text("Total Game :$gamePlayed/Game Won $gameWon"),
                        Text("Percentage :$winningPrecentage"),
                      ],
                    );
                  });
                },
                child:const Icon(Icons.person_pin,size: 40)),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(100, 23, 45, 4),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            Button(icon: Icons.person,  title:"Offline",loading: _loading,ontap:(){
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
            Button( icon: Icons.person_add_alt_1_rounded,title:"Online",loading:_loading1,ontap:(){
              setState(() {
              _loading1=true;
                });
              Future.delayed(const Duration(seconds: 2),() {
              Navigator.push(context,MaterialPageRoute(builder: (context){
                 return const SelectMode();
              }));
              setState(() {
                _loading1=false;
                  });
                },);
              },
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height*0.03
            ),
            Button( icon: Icons.leaderboard,title:"Tournament",loading:_loading2,ontap:(){

            },)
          ],
        ),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/cutomWidget/Button.dart';
import 'package:tic_tac_toe_game/imagesString.dart';

import 'gameEnterenceScreen.dart';

class SelectGameMode extends StatefulWidget {
  const SelectGameMode({Key? key}) : super(key: key);
  @override
  _SelectGameModeState createState() => _SelectGameModeState();
}

class _SelectGameModeState extends State<SelectGameMode> {

  List<String> listitems = ["3x3", "6x6", "9x9", "11x11"];
  String selectval = "3x3";
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:const Text("Game Mode"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon:const Icon(Icons.arrow_back_ios),onPressed:(){
          Navigator.pop(context);
        } ),
      ),
      backgroundColor: Colors.black,
      body:Column(
        children: [
          SizedBox(
            height: size.height*0.00,
          ),
          CarouselSlider(
              items: [
                container(Iconpic, () { print("3x3");}),
                container(img6x6, () { print("6x6");})
              ],
              options: CarouselOptions(
                reverse: true,
                autoPlay: true,
                // autoPlayInterval:const Duration(seconds: 3),
                enlargeCenterPage: true,
                autoPlayCurve: Curves.easeInOut,
                viewportFraction: 0.6,
                height: 350,
              )
          ),
          // Container(
          //   width: size.width*0.9,
          //   height: size.height*0.45,
          //   decoration:const BoxDecoration(
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image: AssetImage(Iconpic),
          //     )
          //   ),
          // ),

    DropdownButton(
      hint: const Text("Select Grid"),
      isDense: true,
      icon:const Icon(Icons.arrow_drop_down,color: Colors.white,),
      iconSize: 25,
      dropdownColor: Colors.transparent,
      value: selectval,
      onChanged: (value){
        setState(() {
          selectval = value.toString();
        });
      },
      items: listitems.map((itemone){
        return DropdownMenuItem(
            value: itemone,
            child: Text(itemone,style: const TextStyle(color: Colors.white),)
        );
      }).toList(),
    ),
          SizedBox(
            height: size.height/15,
          ),
          GestureDetector(
            onTap: (){
              if(selectval.isNotEmpty){
                if(selectval=="3x3") {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const GameEntranceScreen();
                      }));
                }else{
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const SelectGameMode();
                      }));
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              height: size.height*0.06,
              width: size.width*0.8,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width/10,
                  ),
                  const Icon(Icons.play_arrow_rounded,size: 50,color: Colors.red),
                  SizedBox(
                    width:size.width*0.10,
                  ),
                  Center(child:
                  loading ? const CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.red,
                  )
                      : const Text("Play",style:TextStyle(color: Colors.red,fontSize: 30),)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

container(String img,VoidCallback ontaped){
   return Center(
     child: GestureDetector(
      onTap: ontaped,
      child: Container(
        decoration:BoxDecoration(
            borderRadius:const BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
              alignment: Alignment.center,
                image: AssetImage(img),
                fit: BoxFit.cover
            )
        ),
      ),
  ),
   );
}
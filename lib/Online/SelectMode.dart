import 'package:flutter/material.dart';
import '../gameScreen/Board.dart';
import '../gameScreen/gameEnterenceScreen.dart';
import '../imagesString.dart';


class SelectMode extends StatefulWidget {
  const SelectMode({Key? key}) : super(key: key);
  @override
  _SelectModeState createState() => _SelectModeState();
}

class _SelectModeState extends State<SelectMode> {

  List<String> listitems = ["3x3", "6x6", "9x9"];
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
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
                return const GameEntranceScreen();
              }));
        } ),
      ),
      backgroundColor: Colors.transparent,
      body:Column(
        children: [
          const Image(image: AssetImage(Iconpic)),
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
                        return BoardBoxes(crossaxiscount: "3",title: selectval,);
                      }));
                }else if(selectval=="6x6"){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return BoardBoxes(crossaxiscount: "6",title: selectval,);
                      }));
                }else if(selectval=="9x9"){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return BoardBoxes(crossaxiscount:"9" ,title: selectval,);
                      }));
                }
              }
            },
            child: Center(
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
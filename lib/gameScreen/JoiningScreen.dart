import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/cutomWidget/Button.dart';
import 'onlineGameBoard.dart';


class JoiningScreen extends StatefulWidget {
  const JoiningScreen({Key? key}) : super(key: key);

  @override
  State<JoiningScreen> createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  final _ip=TextEditingController();
  final _portNumber=TextEditingController();
  int count=0;
  String receiveddata='';
  late Socket socket;
  String message = 'Connecting to server...';
  @override
  void dispose() {
    super.dispose();
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<String> list=["Abdul Islam","Sami"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _ip,
                decoration:const InputDecoration(
                  hintText: 'Enter Ip address',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _portNumber,
                decoration:const InputDecoration(
                  hintText: '9254',
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Button(title: "Enter", ontap: ()async{
                socket = await Socket.connect(_ip.text.toString(),9254);
                receiveDataFromServer();
                Future.delayed(const Duration(seconds: 1),(){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return OnlineBoardBoxes(crossAxisCount: "6",ip: _ip.text.toString(),symbol: receiveddata,socket: socket,);
                  }));
                });
              })
            ],
          ),
        ),
      ),
    );
  }
  //sendDataToServer
/*  void sendDataToServer() async {
    socket.write("Player 1");
  }*/
  void receiveDataFromServer(){
      socket.listen((List<int> data) {
      receiveddata = String.fromCharCodes(data);
      print("Data Received : "+receiveddata);
    },
    );
  }
}
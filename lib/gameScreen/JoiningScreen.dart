import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/cutomWidget/Button.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class JoiningScreen extends StatefulWidget {
  const JoiningScreen({Key? key}) : super(key: key);

  @override
  State<JoiningScreen> createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  final _ip=TextEditingController();
  final _portNumber=TextEditingController();
  final bool _loading = false;
  late Socket socket;
  String message = 'Connecting to server...';
  @override
  void dispose() {
    socket?.destroy();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    connectToServer();
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
              Button(title: "Enter", ontap: (){
                  connectToServer();
              })
            ],
          ),
        ),
      ),
    );
  }
/*  Future<void> connectToServer() async {
    final socket = await Socket.connect(_ip.toString(), 9254);
    print("connected to Server");
    try{
      socket.write("Abdul Islam Ghani");
      socket.listen((data) {
//        String receivedData = utf8.decode(data);
        print('Received data: $data');
      },
        onError: (error) {
          print('Error: $error');
        },
        onDone: () {
          print('Connection closed');
        },
      );
    }catch(e){
      print(e.toString());
    }
    socket.close();
  }*/
  Future<void> connectToServer() async {
    try {
      socket = await Socket.connect(_ip.toString(), 9250);
      setState(() {
        message = 'Connected to server';
      });

      // Use the socket for communication
      // e.g., socket.write('Hello server');
      //       socket.listen((data) => print('Received: $data'));
    } catch (e) {
      setState(() {
        message = 'Error: $e';
      });
    }
  }
}
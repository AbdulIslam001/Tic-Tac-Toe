import 'dart:core';

import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final IconData? icon;
  bool loading =false;
  Button({Key? key,required this.title , required this.ontap, this.icon ,  this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Center(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.circular(15),
          ),
          height: size.height*0.06,
          width: size.width*0.8,
          child: Row(
            children: [
              Icon(icon),
              SizedBox(
                width:size.width*0.25,
              ),
              Center(child:
              loading ? const CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.red,
              )
                  : Text(title,style:const TextStyle(color: Colors.red),)),
            ],
          ),
        ),
      ),
    );
  }
}

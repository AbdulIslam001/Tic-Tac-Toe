import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tic_tac_toe_game/imagesString.dart';
import 'package:page_transition/page_transition.dart';
import '../gameScreen/gameEnterenceScreen.dart';
class StartingSplashScreen extends StatelessWidget {
  const StartingSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedSplashScreen(
      backgroundColor:Colors.black,
          splash: Column(
            children: [
              const Text("Tic \n\t\t Tac \n\t\t\t\t Toe",style: TextStyle(fontSize: 50 ,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,  color: Colors.red),),
              Image.asset("assets/icon2.gif",width: size.width*1,height: size.height*0.3,fit: BoxFit.fill),
            ],
          ),
          splashIconSize: 600,
          duration: 4300,
          pageTransitionType: PageTransitionType.bottomToTop,
          splashTransition: SplashTransition.slideTransition,
          nextScreen: const GameEntranceScreen()
      ),
    );
  }
}

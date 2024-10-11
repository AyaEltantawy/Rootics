import 'package:flutter/material.dart';
import 'package:rootics_final/view/App_InfoScreen.dart';

import 'delay.dart';

class welcomePage extends StatefulWidget {
  const welcomePage({super.key});

  @override
  State<welcomePage> createState() => welcomePageState();
}

class welcomePageState extends State<welcomePage> {
  double boxHeith = 100;
  double boxWidth = 100;
  BoxDecoration decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(3000),
      gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(67, 255, 255, 255),
            Color.fromRGBO(147, 194, 194, 0.004),
          ]));

  void _expandBox() async {
    setState(() {
      boxHeith = MediaQuery.of(context).size.height;
      boxWidth = MediaQuery.of(context).size.width;
      decoration = BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(253, 128, 245, 187),
                Color.fromARGB(236, 67, 203, 135),
                // Color(0x665ac18e),
              ]));
    });
    //delay
    await delay(3500);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const App_InfoScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _expandBox,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(seconds: 3),

            // alignment: Alignment.center,
            //child: CustomContainer(),
            height: boxHeith,
            width: boxWidth,
            decoration: decoration,

            child: Image.asset(
              "lib/assets/images/logo.png",
              height: 50,
              width: 50,
            ),
          ),
        ),
      ),
    );
  }
}

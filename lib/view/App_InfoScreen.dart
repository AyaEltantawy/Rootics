import 'package:flutter/material.dart';

import 'package:rootics_final/view/login_page.dart';




class App_InfoScreen extends StatefulWidget {
  const App_InfoScreen({super.key});

  @override
  State<App_InfoScreen> createState() => _App_InfoScreenState();
}

class _App_InfoScreenState extends State<App_InfoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [
                        Color(0x335ac18e),
                        Color(0x665ac18e),
                        // Color(0x665ac18e),
                      ]),


                ),

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(
                      height: 460,
                      width: double.infinity,
                      fit: BoxFit.fill,

                      image: AssetImage("lib/assets/images/app_info_image.png"),
                    ),

                    const SizedBox(height: 1),
                    Center(
                      child: Column(
                        children: [
                          Text("Rootics", style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(183, 0, 0, 0),
                          ),)
                          ,Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: const Text(


                              " هو تطبيق مهتم برعايةالنباتات والتعرف عليها وتحديد امراضها      "



                              ,
                              style: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(183, 0, 0, 0),
                              ),
                            ),

                          ),
                          Text("وطرق علاجها", style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(183, 0, 0, 0),
                          ),)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  LoginPage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Container(
                          width: 130,
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(161, 10, 56, 10),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Icon(Icons.arrow_forward,),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),


            )
        ),
      ),
    );
  }



}

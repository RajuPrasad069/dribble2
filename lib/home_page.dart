import 'package:flutter/material.dart';

import 'Header_Screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80,left: 80,right: 80,bottom:40 ),
            child: Image.asset("assets/Images/avocado.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text("We deliver groceries at your doorstep",textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
          ),
          Text("Fresh items everyday"),
          SizedBox(height: 30,),
          //get started button
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HeaderPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.all(24),
              child: Text("Get Started",style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}

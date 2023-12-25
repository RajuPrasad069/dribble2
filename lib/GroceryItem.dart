import 'package:flutter/material.dart';
class GroceryItemTile extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final color;
  void Function()? onPressed;

   GroceryItemTile({super.key,
    required this.itemName,
    required this.itemPrice,
    required this.imagePath,
    this .color,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: color[100],
          borderRadius: BorderRadius.circular(12)
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(imagePath,height: 40,),
            Text("itemName"),

            MaterialButton(
              onPressed: onPressed,
              color: color[800],
              child: Text('\$'+itemPrice,style: TextStyle(color: Colors.white
              ,fontWeight: FontWeight.bold),),

            )
          ],
        ),
      ),
    );

  }
}

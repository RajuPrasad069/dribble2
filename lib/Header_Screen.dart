import 'package:dribble2/CartPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'GroceryItem.dart';
import 'Model/cart_model.dart';

class HeaderPage extends StatefulWidget {
  const HeaderPage({super.key});

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context){
            return CartPage();
          })),
          backgroundColor: Colors.black,
          child: Icon(Icons.shopping_bag,color: Colors.white,),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text("Good Morning"),
            ),
            // Let's order fresh items for you
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Let's order fresh items for you",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 24,
            ),

            //divider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),
            SizedBox(
              height: 24,
            ),

            //fresh items + grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                "Fresh Items",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
                child: Consumer<CartModel>(builder: (context, Value, child) {
              return GridView.builder(
                  itemCount: Value.shopItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                  childAspectRatio: 1/1.3),
                  itemBuilder: (context, index) {
                    return GroceryItemTile(
                      itemName: Value.shopItems[index][0],
                      itemPrice: Value.shopItems[index][1],
                      imagePath:Value.shopItems[index][2],

                      color: Value.shopItems[index][3], onPressed: () {
                        Provider.of<CartModel>(context,listen: false).addItemToCart(index);
                    },

                    );
                  });
            }))
          ],
        ),
      ),
    );
  }
}

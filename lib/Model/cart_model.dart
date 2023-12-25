import 'package:flutter/material.dart';
class CartModel extends ChangeNotifier {
  //list of item on sale
  final List _shopItems = [
    //[itemsName, itmePrice,imagePath,color]
    ["Avocado","4.00","assets/Images/avocado.png",Colors.green],
    ["Banana","2.50","assets/Images/banana.png",Colors.yellow],
    ["chicken","12.80","assets/Images/chicken.png",Colors.brown],
    ["water","1.00","assets/Images/water.png",Colors.blue],

  ];
  // List of cart items
  List _cartItems = [];
  get shopItems => _shopItems;
  get cartItems => _cartItems;
  //add item to cart
void addItemToCart(int index){
  _cartItems.add(_shopItems[index]);
  notifyListeners();
}
// remove item from cart
void removeItemFromCart(int index){
  _cartItems.removeAt(index);
  notifyListeners();

}
//calculate total price
String calculateTotal(){
  double totalPrice = 0;
  for(int i=0; i< _cartItems.length; i++){
    totalPrice += double.parse(_cartItems[i][1]);
  }
  return totalPrice.toStringAsFixed(2);
}
}
import 'package:flutter/material.dart';
import 'product.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'MAWLA',
            style: TextStyle(
              fontFamily: 'Cleancut',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'img/ShopingCart01.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black87,
                        ],
                        stops: [0, 0.5],
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'CART',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontFamily: 'Nevan',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: cartitems.length,
                    itemBuilder: (b,i)
                    {
                      return ListTile(
                        leading: Image.asset(
                          cartitems[i].imageUrl,
                          fit: BoxFit.cover,
                          width: 110,
                          height: 110,
                        ),
                        title: Text(cartitems[i].name, style: TextStyle(fontFamily: 'Nevan', fontSize: 25),),
                        subtitle: Text(cartitems[i].category,style: TextStyle(fontFamily: 'Nevan', fontSize: 15),),
                        trailing: Text(cartitems[i].price.toString(),style: TextStyle(fontFamily: 'Nevan', fontSize: 25),),
                      );
                    }))
          ],
        )
    );
  }
}

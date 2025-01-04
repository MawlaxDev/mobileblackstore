import 'package:flutter/material.dart';

import 'CartList.dart';

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String details;
  final String category;

  Product(this.name, this.imageUrl, this.price, this.details, this.category);
}


List<Product> allproducts =[];
List<Product> cartitems= [];

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Nevan', // Title color
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartPage())
                    );
                  },
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Hero(
                  tag: product.name,
                  child: Image.asset(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 400,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Nevan',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Nevan',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: 'Nevan'),
            ),
            const SizedBox(height: 25),
            Text(
              product.details,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Isocreur',
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () {
                cartitems.add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
              },
              child: const Text('Add to Cart', style: TextStyle(fontFamily: 'Nevan', color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'categories.dart';
import 'CartList.dart';
import 'itemLister.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Categories> categories = [
    Categories(name: 'home', imageUrl: 'img/home.jpg'),
    Categories(name: 'accessory', imageUrl: 'img/Accessories01.jpg'),
    Categories(name: 'clothe', imageUrl: 'img/Clothe.jpg'),
    Categories(name: 'electronics', imageUrl: 'img/electronics04.jpg'),
  ];

  List<Product> allproducts = [];

  String selectedCategory = 'home';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String path = "http://mawlaastore.atwebpages.com/getProducts.php";
    Uri url = Uri.parse(path);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          allproducts.clear();
          var jsonArray = convert.jsonDecode(response.body);
          print('Fetched products: $jsonArray');
          for (var row in jsonArray) {
            Product p = Product(
              row['name'] ?? 'Unknown',
              row['imageUrl'] ?? 'No image URL',
              double.tryParse(row['price']) ?? 0.0, 
              row['details'] ?? 'No details',
              row['category'] ?? 'Unknown',
            );
            allproducts.add(p);
          }
        });
      } else {
        print('Failed to load products. HTTP Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Categories currentCategory = categories.firstWhere((category) => category.name == selectedCategory);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                  color: Colors.white,
                );
              },
            )

          ],
        ),
        backgroundColor: Colors.black,
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text(
                  'MAWLA',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Cleancut',
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.white),
                title: Text('Home', style: TextStyle(color: Colors.white, fontFamily: 'Nevan')),
                onTap: () {
                  setState(() {
                    selectedCategory = 'home';
                  });
                  Navigator.pop(context);
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.category, color: Colors.white),
                title: Text('Categories', style: TextStyle(color: Colors.white, fontFamily: 'Nevan')),
                children: [
                  ListTile(
                    leading: Icon(Icons.accessibility_new, color: Colors.white),
                    title: Text('Accessories', style: TextStyle(color: Colors.white, fontFamily: 'Nevan')),
                    onTap: () {
                      setState(() {
                        selectedCategory = 'accessory';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.yard_sharp, color: Colors.white),
                    title: Text('Clothes', style: TextStyle(color: Colors.white, fontFamily: 'Nevan')),
                    onTap: () {
                      setState(() {
                        selectedCategory = 'clothe';
                      });
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.devices, color: Colors.white),
                    title: Text('Electronics', style: TextStyle(color: Colors.white, fontFamily: 'Nevan')),
                    onTap: () {
                      setState(() {
                        selectedCategory = 'electronics';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 220,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      currentCategory.imageUrl,
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
                        currentCategory.name.toUpperCase(),
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
              ListProducts(category: currentCategory.name, products: allproducts),
            ],
          ),
        ),
      ),
    );
  }
}

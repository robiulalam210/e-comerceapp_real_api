import 'package:flutter/material.dart';
import 'package:real_api/scrren/auth/loginpage.dart';
import 'package:real_api/scrren/nav_bar/category_page.dart';
import 'package:real_api/scrren/nav_bar/order_page.dart';
import 'package:real_api/scrren/nav_bar/product_page.dart';
import 'package:real_api/scrren/nav_bar/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final _pages = [
    ProdactPage(),
    CategoryPage(),
    OrderPage(),
    ProfilePage(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.getString("token");
                sharedPreferences.clear();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Colors.deepOrange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            label: "Prodact",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: "Catagory"),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_to_action_outlined),
            label: "Order",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}

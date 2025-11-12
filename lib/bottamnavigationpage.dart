import 'package:flutter/material.dart';
import 'package:medicalapp/homepage.dart';
import 'package:medicalapp/mybookings.dart';
import 'package:medicalapp/wishlistpage.dart';

// Global shared lists for wishlist & bookings
List<Map<String, String>> wishlist = [];
List<Map<String, String>> bookings = [];

class Bottamapppage extends StatefulWidget {
  const Bottamapppage({super.key});

  @override
  State<Bottamapppage> createState() => _BottamapppageState();
}

class _BottamapppageState extends State<Bottamapppage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onWishlistChanged: () => setState(() {})),
      WishlistPage(wishlist: wishlist),
      MyBookingsPage(),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: "Bookings",
          ),
        ],
      ),
    );
  }
}

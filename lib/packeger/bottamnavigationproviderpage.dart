import 'package:flutter/material.dart';
import 'package:medicalapp/bookingspage.dart';
import 'package:medicalapp/listingpage.dart';
import 'package:medicalapp/providerdashbordpage.dart';
import 'package:medicalapp/providerprofile.dart';

class BottomNavPagepovider extends StatefulWidget {
  const BottomNavPagepovider({super.key});

  @override
  State<BottomNavPagepovider> createState() => _BottomNavPagepoviderState();
}

class _BottomNavPagepoviderState extends State<BottomNavPagepovider> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    DashboardScreen(),
    ListingPage(),
    BookingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: "Listings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online_outlined),
            activeIcon: Icon(Icons.book_online),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

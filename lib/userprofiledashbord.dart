import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;

  const UserProfileScreen({
    Key? key,
    required this.name,
    required this.role,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "My Travel Hub",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey[800]),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AVATAR with shadow
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.18),
                      blurRadius: 18,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 54,
                  backgroundImage: AssetImage(avatarUrl),
                ),
              ),
              SizedBox(height: 18),
              // Name (bold)
              Text(
                name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.25,
                  color: Colors.grey[900],
                ),
              ),
              // Role/subtitle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  role,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                "Travel Hubber",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),

              SizedBox(height: 32),
              // Card-style info section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 26,
                    horizontal: 18,
                  ),
                  child: Column(
                    children: [
                      ProfileInfoRow(
                        label: "Email",
                        value: "alexdoe@email.com",
                      ),
                      ProfileInfoRow(label: "Phone", value: "+91 91234 56789"),
                      ProfileInfoRow(label: "Member Since", value: "2022"),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 22),
              // Edit profile button with gradient and elevation
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  elevation: 3,
                  shape: StadiumBorder(),
                ),
                icon: Icon(Icons.edit, color: Colors.white, size: 20),
                label: Text("Edit Profile", style: TextStyle(fontSize: 15)),
                onPressed: () {
                  // Edit profile action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// InfoRow widget for card section
class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;
  const ProfileInfoRow({Key? key, required this.label, required this.value})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label:",
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 12),
          Text(
            value,
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

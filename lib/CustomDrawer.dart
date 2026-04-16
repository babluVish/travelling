import 'package:adbhut/EnquiryList.dart';
import 'package:adbhut/main.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // 🔷 Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/logo.png"),
                ),
                SizedBox(height: 10),
                Text(
                  "Deepak Srivastava",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  "deepak@email.com",
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          // 🔹 Menu Items
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text("Enquiry"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => EnquiryList()),
                (route) => false,
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.search),
            title: Text("Search"),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {},
          ),

          Divider(),

          // 🔻 Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text("Logout"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

// Dummy Login Page
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Login Page")));
  }
}

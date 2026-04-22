import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeddingPlannerHome(),
    );
  }
}

class WeddingPlannerHome extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Decoration'),
    Tab(text: 'Mehandi'),
    Tab(text: 'Video Recording'),
    Tab(text: 'Band Baza Barat'),
    Tab(text: 'Gallery'),
    Tab(text: 'Dulhan Sajawat'),
    Tab(text: 'Contact US'),
  ];

  final List<String> carouselImages = [
    'assets/logo.png',
    'assets/logo3.png',
    // Add more image paths if you have them
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Wedding Planner'),
          bottom: TabBar(tabs: myTabs, isScrollable: true),
        ),
        body: TabBarView(
          children: [
            DecorationPage(),
            MehandiPage(),
            VideoRecordingPage(),
            BandBazaBaratPage(),
            GalleryPage(),
            DulhanSajawatPage(),
            ContactUsPage(),
          ],
        ),
      ),
    );
  }
}

class DecorationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Decoration Services', style: TextStyle(fontSize: 22)),
    );
  }
}

class MehandiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Mehandi Services', style: TextStyle(fontSize: 22)),
    );
  }
}

class VideoRecordingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Video Recording Services', style: TextStyle(fontSize: 22)),
    );
  }
}

class BandBazaBaratPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Band Baza Barat Services', style: TextStyle(fontSize: 22)),
    );
  }
}

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Gallery', style: TextStyle(fontSize: 22)));
  }
}

class DulhanSajawatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Dulhan Sajawat Services', style: TextStyle(fontSize: 22)),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.contact_mail, size: 60, color: Colors.pink),
          SizedBox(height: 20),
          Text(
            'Contact Us',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Email: info@weddingplanner.com',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text('Phone: +91 98765 43210', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text(
            'Address: 123, Main Road, Your City',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

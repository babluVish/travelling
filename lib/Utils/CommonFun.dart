import 'package:flutter/material.dart';

Widget notificationUI() {
  return Stack(
    children: [
      IconButton(icon: Icon(Icons.notifications, size: 40), onPressed: () {}),
      // 🔴 Badge
      Positioned(
        right: 15,
        top: 23,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(minWidth: 18, minHeight: 18),
          child: Text(
            '5', // 👉 your count here
            style: TextStyle(color: Colors.white, fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

Widget bottomUI() {
  return SafeArea(
    child: Container(
      padding: EdgeInsets.all(16),
      child: Text(
        '@ Copyright 2026 Get Set Adventure. All rights reserved.',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

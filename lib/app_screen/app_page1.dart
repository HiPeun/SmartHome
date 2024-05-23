import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Conven",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Container(
            margin: EdgeInsets.all(20),
            width: 140,
            height: 140,
            color: Color(0xFFE5E5E1),
            child: Image.asset("assets/images/speakerimage.png"),
          ),

          Container(
            margin: EdgeInsets.all(20),
            width: 140,
            height: 140,
            color: Color(0xFFE5E5E1),
            child: Image.asset("assets/images/noteimage.png"),
          ),
        ],
      ),

    );
  }
}


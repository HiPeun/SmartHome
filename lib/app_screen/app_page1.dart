import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    color: Color(0xFFE5E5E1),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    color: Color(0xFFE5E5E1),
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SearchBar(
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                    constraints: BoxConstraints(maxHeight: 100, maxWidth: 250),
                    shape: MaterialStateProperty.all(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    hintText: "검색어를 입력하세요",
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.black,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Color(0xFFE5E5E1),
                  )
                ],

              ),

            )
          ],
        ),
      ),
    );
  }
}

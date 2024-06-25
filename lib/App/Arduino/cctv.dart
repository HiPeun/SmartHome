import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class CcTv extends StatefulWidget {
  @override
  _CcTvState createState() => _CcTvState();
}

class _CcTvState extends State<CcTv> {
  bool _isStreaming = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CCTV"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 400),
            child: Mjpeg(
              stream: 'http://192.168.0.192:91/stream',
              isLive: _isStreaming,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isStreaming = true;
                    });
                  },
                  child: Icon(Icons.play_arrow),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isStreaming = false;
                    });
                  },
                  child: Icon(Icons.pause),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

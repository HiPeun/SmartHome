import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

class CcTv extends StatefulWidget {
  @override
  _CcTvState createState() => _CcTvState();
}

class _CcTvState extends State<CcTv> {
  bool _isStreaming = true;

  void _rebuildStream() {
    setState(() {
      _isStreaming = false;
    });
    // 스트리밍을 다시 시작하기 전에 충분한 지연 시간을 줍니다.
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isStreaming = true;
      });
    });
  }

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
              stream: 'http://192.168.0.200:93/stream',
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
                  heroTag: 'play_button',
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
                  heroTag: 'pause_button',
                  backgroundColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      _isStreaming = false;
                    });
                  },
                  child: Icon(Icons.pause),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  heroTag: 'refresh_button',
                  backgroundColor: Colors.white,
                  onPressed: _rebuildStream,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

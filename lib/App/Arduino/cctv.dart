import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:http/http.dart' as http;

class CcTv extends StatefulWidget {
  @override
  _CcTvState createState() => _CcTvState();
}

class _CcTvState extends State<CcTv> {
  bool _isStreaming = true;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _startStreaming();
    _checkStreamStatus();
  }

  void _startStreaming() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isStreaming = true;
        _isLoading = false;
      });
    });
  }

  void _handleStreamError() {
    setState(() {
      _isError = true;
      _isStreaming = false;
    });
    Future.delayed(Duration(seconds: 5), () {
      _startStreaming();
    });
  }

  void _checkStreamStatus() async {
    while (true) {
      try {
        final response = await http.get(Uri.parse('http://192.168.0.200:93/stream'));
        if (response.statusCode != 200) {
          _handleStreamError();
        }
      } catch (e) {
        _handleStreamError();
      }
      await Future.delayed(Duration(seconds: 10));
    }
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
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else if (_isError)
            Center(
                child: Text("CCTV 연결에 실패 했습니다.",
                    style: TextStyle(color: Colors.red, fontSize: 20)))
          else
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
                      _isError = false;
                      _isLoading = false;
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
                  onPressed: _startStreaming,
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

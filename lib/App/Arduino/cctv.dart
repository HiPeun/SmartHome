import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Cctv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32-CAM 스트리밍 보기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamScreen(),
    );
  }
}

class StreamScreen extends StatefulWidget {
  @override
  _StreamScreenState createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  late VideoPlayerController _controller;
  final String streamUrl = 'https://192.168.0.194:93/stream';

  @override
  void initState() {
    super.initState();
    _initializeStream();
  }

  void _initializeStream() async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(streamUrl));

    try {
      await _controller.initialize();
      _controller.play();
    } catch (e) {
      print('Error initializing video player: $e');
    }

    _controller.addListener(() {
      if (_controller.value.hasError) {
        print('VideoPlayer error: ${_controller.value.errorDescription}');
        // Handle error during playback here
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ESP32-CAM 스트리밍'),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
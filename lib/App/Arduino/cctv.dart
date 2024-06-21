import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;



class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Stream App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LiveStreamPage(),
    );
  }
}

class LiveStreamPage extends StatefulWidget {
  const LiveStreamPage({Key? key}) : super(key: key);

  @override
  _LiveStreamPageState createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    final url = 'http://192.168.0.194:93/stream';
    try {
      // 먼저 URL이 접근 가능한지 체크
      final response = await http.head(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        _controller = VideoPlayerController.network(url)
          ..initialize().then((_) {
            setState(() {
              _isLoading = false;
              _controller?.play();
            });
          });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Failed to load video: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        if (e is TimeoutException) {
          _errorMessage = 'Failed to load video: TimeoutException';
        } else {
          _errorMessage = 'Failed to load video: $e';
        }
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Stream'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : _hasError
            ? Text(_errorMessage)
            : _controller != null && _controller!.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        )
            : const Text('Initializing video...'),
      ),
      floatingActionButton: _isLoading || _hasError
          ? null
          : FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
          });
        },
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

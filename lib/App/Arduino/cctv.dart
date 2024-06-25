import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoPlayerExample extends StatefulWidget {
  @override
  _VideoPlayerExampleState createState() => _VideoPlayerExampleState();
}

class _VideoPlayerExampleState extends State<VideoPlayerExample> {
  late VlcPlayerController _vlcViewController;

  @override
  void initState() {
    super.initState();
    _vlcViewController = VlcPlayerController.network(
      'http://192.168.0.192:91/stream',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _vlcViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CCTV Stream'),
      ),
      body: Center(
        child: VlcPlayer(
          controller: _vlcViewController,
          aspectRatio: 16 / 9,
          placeholder: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

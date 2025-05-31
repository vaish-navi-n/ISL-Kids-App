import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String label;

  const VideoScreen({required this.label});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  bool isLoading = true;
  double _playbackSpeed = 1.0;

  // Map of video URLs
  final Map<String, String> videoUrls = {
    'A': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FA.mp4?alt=media&token=12c2d793-8c5d-4847-8826-09f6a88eddc4',
    'B': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FB.mp4?alt=media&token=f91dc2c2-3d63-4fac-a56f-0b28673293ed',
    'C': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FC.mp4?alt=media&token=7aa9df7c-b008-47c0-862a-5ee3420f7a6a',
    'D': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FD.mp4?alt=media&token=dff6ccc4-21d3-4751-b873-0eb6ad8e3b4e',
    'E': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FE.mp4?alt=media&token=ac5b0a14-ea2e-494b-84ec-69cc1ffe75c2',
    'F': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FF.mp4?alt=media&token=17c417e4-dae5-4c0e-88c8-51b6114b3ac7', // fixed
    'G': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FG.mp4?alt=media&token=6f63ee51-ace5-4c12-879d-e238386b9d7a',
    'H': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FH.mp4?alt=media&token=2247aeed-fe9a-4e8b-ae14-d857dc24c969',
    'I': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FI.mp4?alt=media&token=b940a205-3cdc-4625-8ae2-1fbaa51ba731',
    'J': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FJ.mp4?alt=media&token=cd258a38-aadc-484c-887e-3236f624c7d0',
    'K': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FK.mp4?alt=media&token=deb8ce61-f766-48dd-869d-78cc16bef16d',
    'L': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FL.mp4?alt=media&token=b47e414b-338d-4b9e-aeec-3900fe130f5f',
    'M': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FM.mp4?alt=media&token=52ecd762-d079-44ad-bfc6-3ccd3100f426',
    'N': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FN.mp4?alt=media&token=cb034ebf-5383-4292-bb48-78dae102ab10',
    'O': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FO.mp4?alt=media&token=f4cc4ce2-94dd-4a30-be97-42a8e42be389',
    'P': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FP.mp4?alt=media&token=b48cd494-fae4-4f53-9362-1a808a78fe1a',
    'Q': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FQ.mp4?alt=media&token=ef7237e1-6062-4771-bc24-b37df9137b64',
    'R': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FR.mp4?alt=media&token=c9a3ab70-7e6f-4a9c-9a9a-aeefae2bbbaf',
    'S': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FS.mp4?alt=media&token=c0a100ad-db73-46fd-b934-b3ce8eb4ca62',
    'T': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FT.mp4?alt=media&token=1e066267-8cab-48fa-8d89-fee5cbf93607',
    'U': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FU.mp4?alt=media&token=d017c173-2e15-491d-82a1-26e0e940fc05',
    'V': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FV.mp4?alt=media&token=0faf4693-6cec-4225-a8fa-4ae1f2b16547',
    'W': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FW.mp4?alt=media&token=cebc2ea0-da58-4250-9867-0d8aeedf1ece',
    'X': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FX.mp4?alt=media&token=2928bd8e-2f3a-4254-a068-ecffc18b7c20',
    'Y': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FY.mp4?alt=media&token=21bd71d8-6cb0-460a-86bf-d2f619315df9',
    'Z': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FAlphabets%2FZ.mp4?alt=media&token=3e6d8748-02bb-4ae1-93e3-d56ce44efddd',
    '1': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F1.mp4?alt=media&token=e2eaaf42-5dc6-426e-96b0-8c87239955fa',
    '2': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F2.mp4?alt=media&token=d9125e0a-a6e5-4925-b54a-4e09478ba921',
    '3': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F3.mp4?alt=media&token=c0e87ff3-99a8-413d-9b34-2a0a552b2e72',
    '4': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F4.mp4?alt=media&token=97f9a7dc-d8c6-49cb-97f5-e21decef04ae',
    '5': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F5.mp4?alt=media&token=578ca2e7-e287-4349-bccb-6c3cef1ae826',
    '6': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F6.mp4?alt=media&token=b91c37c1-2ee8-4e8a-b085-2891a8dfc027',
    '7': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F7.mp4?alt=media&token=d7c09363-8fa0-4af6-89fe-3d8e7cd05afb',
    '8': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F8.mp4?alt=media&token=9a830cb7-98ce-4897-b5fb-fc0494e6ea07',
    '9': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F9.mp4?alt=media&token=b137d145-eda7-4963-bbe9-8ea75d54db93',
    '10': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F10.mp4?alt=media&token=0f485e56-3348-4e44-b7db-6fce381d201f',
    '11': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F11.mp4?alt=media&token=a69d7c00-4451-4645-9f43-b0201dfc502d',
    '12': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F12.mp4?alt=media&token=4ccebfba-117d-45b3-be8b-8d5128bbc9d0',
    '13': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F13.mp4?alt=media&token=5c660771-8043-4e40-aa30-c4d912a09ce5',
    '14': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F14.mp4?alt=media&token=10bc0278-93d0-4466-a569-034f687caefd',
    '15': 'https://firebasestorage.googleapis.com/v0/b/isl-kids-app-e5e12.firebasestorage.app/o/signs%2FNumbers%2F15.mp4?alt=media&token=10d611d4-9c91-437e-9d98-d7ad2bb6142f',
  };

  @override
  void initState() {
    super.initState();
    fetchVideoUrl();
  }

  void fetchVideoUrl() async {
    final url = videoUrls[widget.label.toUpperCase()];
    if (url == null) {
      print("No URL for label: ${widget.label}");
      setState(() => isLoading = false);
      return;
    }

    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() => isLoading = false);
        _controller?.setPlaybackSpeed(_playbackSpeed);
        _controller?.play();
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(' ${widget.label}')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (_controller != null && _controller!.value.isInitialized)
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                      const SizedBox(height: 16),
                      VideoProgressIndicator(_controller!, allowScrubbing: true),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Speed: "),
                          DropdownButton<double>(
                            value: _playbackSpeed,
                            items: [0.25, 0.5, 1.0, 1.5, 2.0]
                                .map((speed) => DropdownMenuItem(
                                      value: speed,
                                      child: Text("${speed}x"),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _playbackSpeed = value;
                                  _controller?.setPlaybackSpeed(_playbackSpeed);
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Here we will learn the sign for: "${widget.label.toUpperCase()}"',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              : Center(child: Text('Video not available')),
      floatingActionButton: (_controller != null && _controller!.value.isInitialized)
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
                });
              },
              child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
            )
          : null,
    );
  }
}

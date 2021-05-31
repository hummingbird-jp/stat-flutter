import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  static const String id = 'video_screen';

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late Widget _webcamWidget;
  final VideoElement _videoElement = VideoElement();

  @override
  void initState() {
    super.initState();

    ui.platformViewRegistry.registerViewFactory(
      'videoElement',
      (int viewId) => _videoElement,
    );

    _webcamWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'videoElement',
    );

    window.navigator
        .getUserMedia(
      video: true,
    )
        .then((MediaStream mediaStream) {
      _videoElement.srcObject = mediaStream;
    });

    _videoElement.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera test'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: _webcamWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

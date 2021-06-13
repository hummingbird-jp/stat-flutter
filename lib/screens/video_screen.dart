import 'dart:html';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

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

  bool _active = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera test'),
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
              Switch(
                  value: _active,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  inactiveThumbColor: Theme.of(context).colorScheme.primary,
                  onChanged: _active
                      ? (bool active) {
                          setState(() {
                            _active = active;
                            _videoElement.pause();
                          });
                        }
                      : (bool active) {
                          setState(() {
                            _active = active;
                            _videoElement.play();
                          });
                        }),
            ],
          ),
        ),
      ),
    );
  }
}

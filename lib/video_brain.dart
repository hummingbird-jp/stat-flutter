import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class VideoBrain {
  late Widget _webcamWidget;
  final VideoElement _videoElement = VideoElement();

  Future<VideoElement> getVideoElement() async {
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

    //_videoElement.play();

    return _videoElement;
  }
}

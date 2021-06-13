import 'dart:html';
import 'dart:ui' as ui;

class VideoBrain {
  final VideoElement _videoElement = VideoElement();

  Future<VideoElement> getVideoElement() async {
    ui.platformViewRegistry.registerViewFactory(
      'videoElement',
      (int viewId) => _videoElement,
    );
    window.navigator
        .getUserMedia(
      video: true,
    )
        .then((MediaStream mediaStream) {
      _videoElement.srcObject = mediaStream;
    });
    _videoElement.play();

    return _videoElement;
  }
}

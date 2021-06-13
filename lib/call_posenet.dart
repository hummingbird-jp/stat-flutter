@JS()
library posenet;

import 'package:js/js.dart';
import 'dart:html';

void callPoseNet(VideoElement videoElement) {
  estimatePoseOnVideo(videoElement);
}

@JS()
external void estimatePoseOnVideo(VideoElement videoElement);

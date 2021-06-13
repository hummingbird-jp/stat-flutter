@JS()
library posenet;

import 'dart:html';
import 'package:js/js.dart';

void callPoseNet(VideoElement videoElement, String email) {
  estimatePoseOnVideo(videoElement, email);
}

@JS()
external void estimatePoseOnVideo(VideoElement videoElement, String email);

async function estimatePoseOnVideo() {
	const videoElement = document.getElementById("video");
	const poseNet = await posenet.load();
	const pose = await poseNet.estimateSinglePose(videoElement, {
		flipHorizontal: false,
	});
	const message = this._isInView(pose)
		? "_isInView: true"
		: "_isInView: false";

	console.log(message);
}

function _isInView(pose) {
	/* 全体のscoreが0.3未満＝画面内にいない */
	if (pose.score < 0.3) {
		return false;
	} else {
		return true;
	}
}

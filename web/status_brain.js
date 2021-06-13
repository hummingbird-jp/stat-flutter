var db = firebase.firestore();

function sendStatusToFirestore(isInView) {
	try {
		db.collection("statuses").add({
			'isInView': isInView,
			'userEmail': "test@email.com",
		});
	} catch (e) {
		console.error(`Failed to send status: ${e}`);
	}
}

async function estimatePoseOnVideo(videoElement) {
	const poseNet = await posenet.load();
	let pose;
	try {
		pose = await poseNet.estimateSinglePose(videoElement, {
			flipHorizontal: false,
		});
	} catch (e) {
		pose = null;
	}
	const isInView = pose == null ? false : _isInView(pose);
	const message = isInView ? "_isInView: true" : "_isInView: false";

	console.log(message);
	console.log(`pose.score: ${pose.score}`);

	sendStatusToFirestore(isInView);

	return isInView;
}

function _isInView(pose) {
	/* 全体のscoreが0.3未満==画面内にいない */
	if (pose.score < 0.3) {
		return false;
	} else {
		return true;
	}
}

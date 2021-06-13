var db = firebase.firestore();

function sendStatusToFirestore(isInView, email) {
	try {
		db.collection("statuses").add({
			'timestamp': new Date(),
			'isInView': isInView,
			'userEmail': email,
		});
	} catch (e) {
		console.error(`Failed to send status: ${e}`);
	}
}

async function estimatePoseOnVideo(videoElement, email) {
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

	sendStatusToFirestore(isInView, email);

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

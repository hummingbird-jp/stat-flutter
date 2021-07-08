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
	const pose = await poseNet.estimateSinglePose(videoElement, {
		flipHorizontal: false,
	});
	let _isInView = false;
	let _confidence = 0.0;

	if (pose === null) {
		console.log('%cSkipped to send \'isInView\' and \'email\', since pose is null.', 'color: red;');
	} else {
		_isInView = _calcIsInView(pose);
		_confidence = pose.score;

		console.log(`_isInView: %c${_isInView}`, 'color: lightskyblue');
		console.log(`_confidence: %c${_confidence}`, 'color: lightskyblue');
		console.log(`-----\n\n`);

		sendStatusToFirestore(_isInView, email);
	}

	return _isInView;
}

function _calcIsInView(pose) {
	/* 全体のscoreが0.3以上 → PCの前にいる */
	return pose.score >= 0.3 ? true : false;
}

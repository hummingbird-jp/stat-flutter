import 'package:flutter/material.dart';
import 'package:stat_flutter/components/person_with_status.dart';

class TeamScreen extends StatefulWidget {
  static const String id = 'team_screen';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stat! Flutter'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PersonWithStatus(
                userImage: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5603AQG7D1xY_YtA6g/profile-displayphoto-shrink_400_400/0/1615853413089?e=1626912000&v=beta&t=aWaLslh_IrP6C-OHWnEYOM_4v5tfv35TgWfM5foBKcs'),
                status: Icons.check,
              ),
            ),
            Expanded(
              child: PersonWithStatus(
                userImage: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5603AQGGhBt6Ckxytg/profile-displayphoto-shrink_400_400/0/1604068708768?e=1626912000&v=beta&t=vc4GysO1ftX8OUB6psN6XJkuz-QdNfygRx2WrCrPgcA'),
                status: Icons.check,
              ),
            ),
            Expanded(
              child: PersonWithStatus(
                userImage: NetworkImage(
                    'https://media-exp1.licdn.com/dms/image/C5103AQEQRhS5GU68WA/profile-displayphoto-shrink_400_400/0/1545331992316?e=1626912000&v=beta&t=cJdEYKOYACtwZ0-qRA3S3b_Ddax4NH6Z-1dGGCNmtrg'),
                status: Icons.close,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

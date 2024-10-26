// import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/mycv/cv_denied.dart';
import 'package:chatbot/ui/mycv/cv_received.dart';
import 'package:chatbot/ui/share/line_top.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../auth/auth_manager.dart';
import 'cv_pending.dart';

class MyCV extends StatefulWidget {
  static const routeName = '/my-cv';

  const MyCV({super.key});

  @override
  _MyCVState createState() => _MyCVState();
}

class _MyCVState extends State<MyCV> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Công việc của tôi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: const LineTop(),
      ),
      body: Container(
        color: Color.fromARGB(255, 234, 234, 234),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 400,
                height: 210,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 230, 230, 230))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobPending()),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.businessTime,
                                color: Colors.orange[400],
                              ),
                            ),
                            const Text(
                              'Công việc đang chờ duyêt',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JobReceived()),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.businessTime,
                                color: Colors.lightGreenAccent[700],
                              ),
                            ),
                            const Text(
                              'Công việc đã nhận',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const JobDenied()),
                          );
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FaIcon(
                                FontAwesomeIcons.businessTime,
                                color: Colors.red[400],
                              ),
                            ),
                            const Text(
                              'Công việc bị từ chối',
                              style: TextStyle(fontSize: 20),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLogoutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthManager>().logout();
        Navigator.of(context).pushReplacementNamed('/');
      },
      icon: const Icon(Icons.exit_to_app),
    );
  }
}

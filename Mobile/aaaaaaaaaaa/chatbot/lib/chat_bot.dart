// // import 'dart:convert';

// // import 'package:dash_chat_2/dash_chat_2.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;

// // class ChatBox extends StatefulWidget {
// //   const ChatBox({super.key});

// //   @override
// //   State<ChatBox> createState() => _ChatBoxState();
// // }

// // const oururl =
// //     'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBitwNPcOKWHH6bSf_NDA3_WN9Qk1EjwBs';

// // final header = {'Content-Type': 'application/json'};

// // class _ChatBoxState extends State<ChatBox> {
// //   ChatUser myself = ChatUser(id: '1', firstName: 'my job');
// //   ChatUser bot = ChatUser(id: '2', firstName: 'bot');
// //   List<ChatMessage> allMessages = [];
// //   List<ChatUser> typing = [];
// //   getdata(ChatMessage m) async {
// //     typing.add(bot);
// //     allMessages.insert(0, m);
// //     setState(() {});
// //     var data = {
// //       "contents": [
// //         {
// //           "parts": [
// //             {"text": m.text}
// //           ]
// //         }
// //       ]
// //     };
// //     await http
// //         .post(Uri.parse(oururl), headers: header, body: jsonEncode(data))
// //         .then((value) {
// //       if (value.statusCode == 200) {
// //         var result = jsonDecode(value.body);
// //         print(result['candidates'][0]['content']['parts'][0]['text']);

// //         ChatMessage m1 = ChatMessage(
// //             text: result['candidates'][0]['content']['parts'][0]['text'],
// //             user: bot,
// //             createdAt: DateTime.now());
// //         allMessages.insert(0, m1);
// //       } else {
// //         print("error occured");
// //       }
// //     }).catchError((e) {});
// //     typing.remove(bot);
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: DashChat(
// //           typingUsers: typing,
// //           currentUser: myself,
// //           onSend: (ChatMessage m) {
// //             getdata(m);
// //           },
// //           messages: allMessages),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:dash_chat_2/dash_chat_2.dart';
// // import 'package:provider/provider.dart';

// // import 'models/job.dart';
// // // import 'ui/products/products_grid.dart';
// // import 'ui/products/products_manager.dart';
// // // import 'package:http/http.dart' as http;

// // class ChatBox extends StatefulWidget {
// //   static const routeName = '/Chat_bot';
// //   const ChatBox({super.key});

// //   @override
// //   State<ChatBox> createState() => _ChatBoxState();
// // }

// // class _ChatBoxState extends State<ChatBox> {
// //   late Future<void> _fetchJobs;
// //   ChatUser myself = ChatUser(id: '1', firstName: 'my job');
// //   ChatUser bot = ChatUser(id: '2', firstName: 'bot');
// //   List<ChatMessage> allMessages = [];
// //   @override
// //   void initState() {
// //     super.initState();

// //     _fetchJobs = context.read<JobsManager>().fetchJobs1(title: '');
// //   }

// //   Future<void> _searchJobsWithMessage(String message) async {
// //     _searchJobs(message);
// //   }

// //   void _searchJobs(String message) {
// //     _fetchJobs = context.read<JobsManager>().fetchJobs1(title: message);
// //     setState(() {});
// //   }

// //   getdata(ChatMessage m) {
// //     allMessages.insert(0, m);
// //     setState(() {});
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back),
// //           onPressed: () {
// //             _fetchJobs = context.read<JobsManager>().fetchJobs1(title: '');
// //             Navigator.of(context).pushReplacementNamed('/');
// //           },
// //         ),
// //       ),
// //       body: DashChat(
// //           currentUser: myself,
// //           onSend: (ChatMessage m) {
// //             _searchJobsWithMessage(m.text);
// //             getdata(m);
// //             print('Message sent: ${m.text}');
// //           },
// //           messages: allMessages),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:provider/provider.dart';

// // import 'models/job.dart';
// import 'ui/products/products_manager.dart';

// class ChatBox extends StatefulWidget {
//   static const routeName = '/Chat_bot';

//   const ChatBox({Key? key}) : super(key: key);

//   @override
//   State<ChatBox> createState() => _ChatBoxState();
// }

// class _ChatBoxState extends State<ChatBox> {
//   // late Future<void> _fetchJobs;

//   ChatUser myself = ChatUser(id: '1', firstName: 'my job');
//   ChatUser bot = ChatUser(id: '2', firstName: 'bot');
//   List<ChatMessage> allMessages = [];
//   @override
//   void initState() {
//     super.initState();
//     _fetchJobs = context.read<JobsManager>().fetchJobs1(title: '');
//   }

//   void getdata(ChatMessage m) {
//     setState(() {
//       allMessages.insert(0, m);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pushReplacementNamed('/');
//           },
//         ),
//       ),
//       body: DashChat(
//           currentUser: myself,
//           onSend: (ChatMessage m) {
//             getdata(m);
//             print('Message sent: ${m.text}');
//           },
//           messages: allMessages),
//     );
//   }
// }

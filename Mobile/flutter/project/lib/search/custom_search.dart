// import 'package:flutter/material.dart';

// // Custom SearchDelegate
// class CustomSearchDelegate extends SearchDelegate<String> {
//   List<String> allData = [
//     'vietnam',
//     'china',
//     'japan',
//     'use',
//     'english',
//     'russia'
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final List<String> searchResult = allData
//         .where(
//             (String word) => word.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return ListView.builder(
//       itemCount: searchResult.length,
//       itemBuilder: (context, index) {
//         final String item = searchResult[index];
//         return ListTile(
//           title: Text(item),
//           onTap: () {
//             close(context, item);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final List<String> suggestionList = allData
//         .where(
//             (String word) => word.toLowerCase().startsWith(query.toLowerCase()))
//         .toList();

//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (context, index) {
//         final String suggestion = suggestionList[index];
//         return ListTile(
//           title: Text(suggestion),
//           onTap: () {
//             query = suggestion;
//           },
//         );
//       },
//     );
//   }
// }

// Main Page
// class SearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search Page'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               showSearch(context: context, delegate: CustomSearchDelegate());
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text(
//           'This is the main content of the search page',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

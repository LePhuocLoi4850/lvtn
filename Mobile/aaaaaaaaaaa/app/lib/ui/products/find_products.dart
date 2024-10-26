import 'package:flutter/material.dart';

import '../../ui/products/products_manager.dart';

import 'package:provider/provider.dart';
import 'products_grid.dart';

enum FilterOptions { favorites, all }

class FindJobsScreen extends StatefulWidget {
  static const routeName = '/find-job';
  const FindJobsScreen({super.key});

  @override
  State<FindJobsScreen> createState() => _FindJobScreenState();
}

class _FindJobScreenState extends State<FindJobsScreen> {
  late Future<void> _fetchJobs;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _fetchJobs = context.read<JobsManager>().fetchJobs1(title: '');
  }

  void _searchJobs() {
    String searchTerm = _searchController.text;

    _fetchJobs = context.read<JobsManager>().fetchJobs1(title: searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _fetchJobs = context.read<JobsManager>().fetchJobs1(title: '');
            // Navigator.of(context).pushReplacementNamed('/');
          },
        ),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 40),
              child: SizedBox(
                width: 330,
                height: 45,
                child: TextField(
                  autofocus: true,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Nhập từ khóa tìm kiếm',
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  onSubmitted: (String searchTerm) {
                    _searchJobs();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _fetchJobs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const JobsGrid(false);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

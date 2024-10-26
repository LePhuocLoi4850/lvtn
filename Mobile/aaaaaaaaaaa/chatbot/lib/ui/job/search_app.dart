import 'package:chatbot/models/job.dart';
import 'package:chatbot/ui/job/list_jobs.dart';
import 'package:chatbot/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../../models/job.dart';

import 'package:provider/provider.dart';

import '../../models/career.dart';
import '../../models/location.dart';

// import 'favorite_products.dart';

enum FilterOptions { favorites, all }

class SearchJobsScreen extends StatefulWidget {
  static const routeName = '/Search-job';
  const SearchJobsScreen({super.key});

  @override
  State<SearchJobsScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchJobsScreen> {
  late Future<void> _searchJob;
  final _searchController = TextEditingController();
  String? _searchTerm;
  CareerManager careerManager = CareerManager();
  Career? selectedCareer;
  LocationManager locationManager = LocationManager();
  Location? selectedLocation;
  int numberOfJobsFound = 0;
  List<Job> jobs = [];
  @override
  void initState() {
    super.initState();
    _searchJob = context.read<JobsManager>().searchTitle(title: '');
  }

  // void _searchJobs() {
  //   String searchTerm = _searchController.text;

  //   _searchJob
  // = context.read<JobsManager>().searchTitle(title: searchTerm);
  // }
  void _searchJobs() {
    String searchTerm = _searchController.text;

    setState(() {
      _searchTerm = searchTerm;
    });

    _searchJob = context.read<JobsManager>().searchTitle(title: searchTerm);
  }

  void _showCareerListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: careerManager.allCareer.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(careerManager.allCareer[index].name),
              onTap: () {
                setState(() {
                  selectedCareer = careerManager.allCareer[index];
                  _searchJob.then((_) {
                    setState(() {
                      numberOfJobsFound = context.read<JobsManager>().itemCount;
                    });
                  });
                });
                Navigator.pop(context);

                _searchJob = context
                    .read<JobsManager>()
                    .searchCareer(career: selectedCareer!.name);
              },
            );
          },
        );
      },
    );
  }

  void _showLocationListBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: locationManager.allLocation.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(locationManager.allLocation[index].name),
              onTap: () {
                setState(() {
                  selectedLocation = locationManager.allLocation[index];
                  _searchJob.then((_) {
                    setState(() {
                      numberOfJobsFound = context.read<JobsManager>().itemCount;
                    });
                  });
                });
                Navigator.pop(context);

                _searchJob = context
                    .read<JobsManager>()
                    .searchAddress(diachi: selectedLocation!.name);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      width: double.infinity,
      height: 45,
      child: TextField(
        autofocus: false,
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Nhập từ khóa tìm kiếm',
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 214, 214, 214), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 1.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          prefixIcon: const Icon(Icons.search),
        ),
        onSubmitted: (String searchTerm) {
          _searchJobs();
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
              child: sizedBox,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _showCareerListBottomSheet(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Màu viền
                        width: 1, // Độ dày viền
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Độ cong của góc
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedCareer?.name ?? 'Ngành nghề',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down_sharp,
                              color: Colors.black87),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showLocationListBottomSheet(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 180,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius:
                          BorderRadius.circular(10), // Độ cong của góc
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedLocation?.name ?? 'Địa điểm',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down_sharp,
                              color: Colors.black87),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _searchTerm = null;
                    _searchController.clear();
                    selectedCareer = null;
                    selectedLocation = null;
                    _searchJob =
                        context.read<JobsManager>().searchTitle(title: '');
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 255, 255),
                  ),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
                child: const Text(
                  'Clear all',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
          if (_searchTerm != null) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Kết quả tìm kiếm cho: $_searchTerm'),
            ),
          ],
          Expanded(
            child: FutureBuilder(
                future: _searchJob,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    return ListJob();
                  }
                }),
          ),
        ],
      ),
      // bottomNavigationBar: BottomSearch(currentIndex: _currentIndex),
    );
  }
}

class BottomSearch extends StatelessWidget {
  const BottomSearch({
    super.key,
    required int currentIndex,
  }) : _currentIndex = currentIndex;

  final int _currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        if (_currentIndex != index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/');
              break;
            case 1:
              Navigator.of(context)
                  .pushReplacementNamed(SearchJobsScreen.routeName);
              break;
            case 2:
              Navigator.of(context)
                  .pushReplacementNamed(UserJobsScreen.routeName);
              break;
            case 3:
              context.read<AuthManager>().logout();
          }
        } else if (index == 0) {
          // Reload logic for Home screen
          Navigator.of(context).pushReplacementNamed('/');
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.house,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: Colors.blue,
          ),
          label: 'Tìm ứng viên',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.solidPaperPlane,
              color: Color.fromARGB(255, 178, 176, 178)),
          label: 'Đăng tin',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.rightFromBracket,
              color: Color.fromARGB(255, 178, 176, 178)),
          label: 'Log out',
        ),
      ],
    );
  }
}

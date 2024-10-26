import 'package:chatbot/models/user.dart';
import 'package:chatbot/ui/screens.dart';
import 'package:flutter/material.dart';
import '../user/user_grid.dart';
// import '../../models/job.dart';

import 'package:provider/provider.dart';

import '../../models/career.dart';
import '../../models/location.dart';
import '../user/users_manager.dart';
// import 'list_company.dart';

// import 'favorite_products.dart';

enum FilterOptions { favorites, all }

class SearchUserScreen extends StatefulWidget {
  static const routeName = '/Search-user';
  const SearchUserScreen({super.key});

  @override
  State<SearchUserScreen> createState() => _SearchJobScreenState();
}

class _SearchJobScreenState extends State<SearchUserScreen> {
  late Future<void> _searchUser;
  final _searchController = TextEditingController();
  String? _searchTerm;
  CareerManager careerManager = CareerManager();
  Career? selectedCareer;
  LocationManager locationManager = LocationManager();
  Location? selectedLocation;
  int numberOfUsersFound = 0;
  List<UserData> user = [];
  @override
  void initState() {
    super.initState();
    _searchUser = context.read<UsersManager>().searchTitle(name: '');
  }

  // void _searchJobs() {
  //   String searchTerm = _searchController.text;

  //   _searchJob
  // = context.read<JobsManager>().searchTitle(title: searchTerm);
  // }
  void _searchUsers() {
    String searchTerm = _searchController.text;

    setState(() {
      _searchTerm = searchTerm;
    });

    _searchUser = context.read<UsersManager>().searchTitle(name: searchTerm);
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
                  _searchUser.then((_) {
                    setState(() {
                      numberOfUsersFound =
                          context.read<UsersManager>().itemCount;
                    });
                  });
                });
                Navigator.pop(context);

                _searchUser = context
                    .read<UsersManager>()
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
                  _searchUser.then((_) {
                    setState(() {
                      numberOfUsersFound =
                          context.read<UsersManager>().itemCount;
                    });
                  });
                });
                Navigator.pop(context);

                _searchUser = context
                    .read<UsersManager>()
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
          _searchUsers();
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
                    _searchUser =
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
                future: _searchUser,
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
                    return UsersGrid();
                  }
                }),
          ),
        ],
      ),
    );
  }
}

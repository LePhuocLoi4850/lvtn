import 'package:flutter/material.dart';
import 'package:project/models/product.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();
  List<Job> jobs = allJobs;
  List<Job> suggestions = [];
  String? _selectedCategory;
  String? _city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm Việc'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  contentPadding: EdgeInsets.all(8)),
              onChanged: onSearchTextChanged,
            ),
          ),
          const SizedBox(
              width: 50), // Add some space between TextField and DropdownButton
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: DropdownButton<String>(
                      hint: const Text('Nghành nghề'),
                      isExpanded: true,
                      underline: SizedBox(),
                      value: _selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                        // You can perform filtering based on the selected category here
                      },
                      style: const TextStyle(
                        color: Colors.black, // Màu chữ
                        fontSize: 15, // Kích thước chữ
                        fontWeight: FontWeight.bold, // Độ đậm của chữ
                      ),
                      dropdownColor: Color.fromARGB(
                          255, 255, 255, 255), // Màu nền của dropdown
                      elevation: 4, // Độ nâng của dropdown
                      icon: const Icon(
                          Icons.arrow_drop_down), // Icon của dropdown
                      // underline: Container(),
                      items: <String>[
                        'Công nghệ thông tin',
                        'Sư phạm, Thời vụ',
                        'Bác sỉ',
                        'Kỹ sư',
                        'Kế toán',
                        'Quản lý'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: DropdownButton<String>(
                      hint: const Text('Tỉnh thành'),
                      isExpanded: true,
                      underline: SizedBox(),
                      value: _city,
                      onChanged: (String? newValue) {
                        setState(() {
                          _city = newValue;
                        });
                        // You can perform filtering based on the selected category here
                      },
                      style: const TextStyle(
                        color: Colors.black, // Màu chữ
                        fontSize: 15, // Kích thước chữ
                        fontWeight: FontWeight.bold, // Độ đậm của chữ
                      ),
                      dropdownColor: Color.fromARGB(
                          255, 255, 255, 255), // Màu nền của dropdown
                      elevation: 4, // Độ nâng của dropdown
                      icon: const Icon(Icons.arrow_drop_down),
                      items: <String>[
                        'Cần Thơ',
                        'Trà Vinh',
                        'Hậu Giang',
                        'An Giang',
                        'Kiên Gianh',
                        'Bến Tre',
                        'Cà Mau',
                        'Sóc Trăng',
                        'Bạc Liêu',
                        'Tiền Giang'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '${suggestions.length} kết quả tìm thấy',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedCategory = null;
                    _city = null;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255),
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
          Expanded(
            child: ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) {
                final job = suggestions[index];
                return ListTile(
                  title: Text(job.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void onSearchTextChanged(String query) {
    if (query.isEmpty) {
      suggestions.clear();
    } else {
      setState(() {
        suggestions = allJobs.where((job) {
          final jobTitle = job.title.toLowerCase();
          final input = query.toLowerCase();
          return jobTitle.contains(input);
        }).toList();
      });
    }
  }
}

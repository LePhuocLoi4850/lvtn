import 'package:chatbot/company_screen.dart';
import 'package:flutter/material.dart';
import '../../models/career.dart';
import '../../user_screen.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';

class UpdateProfilePage extends StatefulWidget {
  static const routeName = '/update';

  final String userId;
  final String email;

  const UpdateProfilePage({
    Key? key,
    required this.userId,
    required this.email,
  }) : super(key: key);

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final AuthService _authService = AuthService();

  UserData? _userData;
  DateTime? _selectedDate;
  CareerManager careerManager = CareerManager();
  Career? selectedCareer;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _ngaysinhController = TextEditingController();
  TextEditingController _gioitinhController = TextEditingController();
  TextEditingController _diachiController = TextEditingController();
  TextEditingController _careerController = TextEditingController();
  TextEditingController _describeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      UserData? userData = await _authService.getUserData(widget.userId);
      if (!mounted) {
        return;
      }
      setState(() {
        _userData = userData;
        _nameController.text = _userData!.name;
        _phoneController.text = _userData!.phone;
        _ngaysinhController.text = _userData!.ngaysinh;
        _gioitinhController.text = _userData!.gioitinh;
        _diachiController.text = _userData!.diachi;
        _careerController.text = _userData!.career;
        _describeController.text = _userData!.describe;
      });
    } catch (error) {
      // Xử lý lỗi nếu cần
      print('Error loading user data: $error');
    }
  }

  void navigateToProfilePage(BuildContext? context, UserData userData) {
    if (context != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UpdateProfilePage(
            userId: userData.userId,
            email: userData.email,
          ),
        ),
      );
    } else {
      print('Error: context is null');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _ngaysinhController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void _showCareerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Chọn ngành nghề',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 900,
                  child: ListView.builder(
                    itemCount: careerManager.allCareer.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: ListTile(
                          title: Text(
                            careerManager.allCareer[index].name,
                          ),
                          onTap: () {
                            setState(() {
                              selectedCareer = careerManager.allCareer[index];
                              _careerController.text =
                                  careerManager.allCareer[index].name;
                            });
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ',
            style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_userData != null) ...[
              const Text(
                'Hãy nhập thông tin cá nhân để xác nhận tài khoản',
                style: TextStyle(fontSize: 20, color: Colors.blue),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Nhập họ và tên',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: 'Nhập số điện thoại',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ngaysinhController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  hintText: 'Ngày tháng năm sinh',
                  hintStyle: TextStyle(color: Colors.grey),
                  suffixIcon: Icon(Icons.calendar_month_rounded),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 0),
                  Text(
                    'Giới tính:',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 0),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Nam',
                        groupValue: _gioitinhController.text,
                        onChanged: (value) {
                          setState(() {
                            _gioitinhController.text = value!;
                          });
                        },
                      ),
                      Text(
                        'Nam',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Nữ',
                        groupValue: _gioitinhController.text,
                        onChanged: (value) {
                          setState(() {
                            _gioitinhController.text = value!;
                          });
                        },
                      ),
                      Text(
                        'Nữ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _showCareerBottomSheet(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _careerController.text.isNotEmpty
                            ? _careerController.text
                            : 'Loại Hình Công Việc',
                        style: TextStyle(
                          color: _careerController.text.isNotEmpty
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : Colors.grey,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _diachiController,
                decoration: InputDecoration(
                  hintText: 'Nhập địa chỉ',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _describeController,
                decoration: InputDecoration(
                  hintText: 'Giới thiệu bản thân',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 255, 255, 255),
        child: ElevatedButton(
          onPressed: () {
            _saveUserData();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.blue),
              ),
              backgroundColor: Colors.blue),
          child: const Text(
            'Cập nhật thông tin',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
      ),
    );
  }

  Future<void> _saveUserData() async {
    try {
      UserData updatedUserData = _userData!.copyWith(
        name: _nameController.text,
        phone: _phoneController.text,
        ngaysinh: _ngaysinhController.text,
        gioitinh: _gioitinhController.text,
        diachi: _diachiController.text,
        career: _careerController.text,
        describe: _describeController.text,
      );

      await _authService.updateUserData(updatedUserData);

      _redirectToNextScreen();
    } catch (error) {
      print('Error saving user data: $error');
    }
  }

  void _redirectToNextScreen() {
    if (_userData!.level == 'user') {
      _redirectToJobOverviewScreen();
    } else {
      _redirectToCompanyOverviewScreen();
    }
  }

  void _redirectToJobOverviewScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  void _redirectToCompanyOverviewScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CompanyScreen(),
      ),
    );
  }
}

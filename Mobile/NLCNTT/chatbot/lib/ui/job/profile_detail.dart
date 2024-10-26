import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../user_provider.dart';

class ProfileDetail extends StatefulWidget {
  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  List<bool> _isEditingList = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ngaysinhController = TextEditingController();
  TextEditingController _gioitinhController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _diachiController = TextEditingController();
  late String _nameValue;
  late String _ngaysinhValue;
  late String _gioitinhValue;
  late String _phoneValue;
  late String _emailValue;
  late String _diachiValue;
  UserData? _initialUserData;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    _isEditingList = List.generate(6, (index) => false);
    _initialUserData = user;
    _nameValue = user?.name ?? '';
    _ngaysinhValue = user?.ngaysinh ?? '';
    _gioitinhValue = user?.gioitinh ?? '';
    _phoneValue = user?.phone ?? '';
    _emailValue = user?.email ?? '';
    _diachiValue = user?.diachi ?? '';
    _nameController = TextEditingController(text: _nameValue);
    _ngaysinhController = TextEditingController(text: _ngaysinhValue);
    _gioitinhController = TextEditingController(text: _gioitinhValue);
    _phoneController = TextEditingController(text: _phoneValue);
    _emailController = TextEditingController(text: _emailValue);
    _diachiController = TextEditingController(text: _diachiValue);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ngaysinhController.dispose();
    _gioitinhController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _diachiController.dispose();
    super.dispose();
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
        _saveChanges(1);
      });
    }
  }

  void _showMale(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 10,
      context: ctx,
      builder: (ctx) => SizedBox(
        width: 410,
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              decoration: const BoxDecoration(color: Colors.grey),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tùy chọn',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _gioitinhController.text = 'Nam';
                      _saveChanges(2);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Nam',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
            const Line(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _gioitinhController.text = 'Nữ';
                      _saveChanges(2);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Nữ',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
            const Line(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _gioitinhController.text = 'Khác';
                      _saveChanges(2);
                      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    'Khác',
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleEditing(int index) {
    setState(() {
      _isEditingList[index] = !_isEditingList[index];
    });
  }

  void _saveChanges(int index) {
    setState(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      switch (index) {
        case 0:
          userProvider.updateUserData(
            _initialUserData!.copyWith(name: _nameController.text),
          );
          break;
        case 1:
          userProvider.updateUserData(
            _initialUserData!.copyWith(ngaysinh: _ngaysinhController.text),
          );
          break;
        case 2:
          userProvider.updateUserData(
            _initialUserData!.copyWith(gioitinh: _gioitinhController.text),
          );
          break;
        case 3:
          userProvider.updateUserData(
            _initialUserData!.copyWith(phone: _phoneController.text),
          );
          break;
        case 4:
          userProvider.updateUserData(
            _initialUserData!.copyWith(email: _emailController.text),
          );
          break;
        case 5:
          userProvider.updateUserData(
            _initialUserData!.copyWith(diachi: _diachiController.text),
          );
          break;
        default:
          break;
      }
      _isEditingList[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin tài khoản'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipOval(
                        child: Container(
                          width: 70,
                          height: 70,
                          child: Icon(
                            Icons.account_circle,
                            size: 70,
                            color: Colors.blue[600],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _isEditingList[0]
                                ? SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      controller: _nameController,
                                      enabled: _isEditingList[0],
                                      onChanged: (value) {
                                        setState(() {
                                          _nameValue = value;
                                        });
                                      },
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 10.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    _nameValue,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            Text(
                              user?.level == 'user'
                                  ? 'Tài khoản ứng viên'
                                  : 'Tài khoản nhà tuyển dụng',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _isEditingList[0]
                      ? GestureDetector(
                          onTap: () => _saveChanges(0),
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleEditing(0);
                            });
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.grey,
                          ),
                        ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15),
                child: Text(
                  'Thông tin cá nhân',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ngày sinh',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        _ngaysinhController.text,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: const FaIcon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Giới tính',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        _gioitinhController.text,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => _showMale(context),
                    child: const FaIcon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Số điện thoại',
                        style: TextStyle(fontSize: 20),
                      ),
                      _isEditingList[3]
                          ? SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _phoneController,
                                enabled: _isEditingList[3],
                                keyboardType: TextInputType.number,
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    _phoneValue = value;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              _phoneValue,
                            ),
                    ],
                  ),
                  _isEditingList[3]
                      ? GestureDetector(
                          onTap: () => _saveChanges(3),
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleEditing(3);
                            });
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.grey,
                          ),
                        ),
                ],
              ),
              const Line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Đ/c email ',
                        style: TextStyle(fontSize: 20),
                      ),
                      _isEditingList[4]
                          ? SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _emailController,
                                enabled: _isEditingList[4],
                                keyboardType: TextInputType.emailAddress,
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    _emailValue = value;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              _emailValue,
                            ),
                    ],
                  ),
                  _isEditingList[4]
                      ? GestureDetector(
                          onTap: () => _saveChanges(4),
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleEditing(4);
                            });
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.grey,
                          ),
                        ),
                ],
              ),
              const Line(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Địa chỉ mặc định',
                        style: TextStyle(fontSize: 20),
                      ),
                      _isEditingList[5]
                          ? SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _diachiController,
                                enabled: _isEditingList[5],
                                keyboardType: TextInputType.streetAddress,
                                autofocus: true,
                                onChanged: (value) {
                                  setState(() {
                                    _diachiValue = value;
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              _diachiValue,
                            ),
                    ],
                  ),
                  _isEditingList[5]
                      ? GestureDetector(
                          onTap: () => _saveChanges(5),
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleEditing(5);
                            });
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.grey,
                          ),
                        ),
                ],
              ),
              const Line()
            ],
          ),
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 10),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[400],
      ),
    );
  }
}

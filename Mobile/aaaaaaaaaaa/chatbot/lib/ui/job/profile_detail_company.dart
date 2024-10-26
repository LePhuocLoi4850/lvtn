import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../user_provider.dart';

class ProfileDetailCompany extends StatefulWidget {
  const ProfileDetailCompany({super.key});

  @override
  State<ProfileDetailCompany> createState() => _ProfileDetailCompanyState();
}

class _ProfileDetailCompanyState extends State<ProfileDetailCompany> {
  List<bool> _isEditingList = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _diachiController = TextEditingController();
  TextEditingController _describeController = TextEditingController();

  late String _nameValue;
  late String _phoneValue;
  late String _emailValue;
  late String _diachiValue;
  late String _describeValue;
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
    _phoneValue = user?.phone ?? '';
    _emailValue = user?.email ?? '';
    _diachiValue = user?.diachi ?? '';
    _describeValue = user?.describe ?? '';

    _nameController = TextEditingController(text: _nameValue);
    _phoneController = TextEditingController(text: _phoneValue);
    _emailController = TextEditingController(text: _emailValue);
    _diachiController = TextEditingController(text: _diachiValue);
    _describeController = TextEditingController(text: _describeValue);
  }

  @override
  void dispose() {
    _nameController.dispose();

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

        _saveChanges(1);
      });
    }
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
            _initialUserData!.copyWith(phone: _phoneController.text),
          );
          break;
        case 2:
          userProvider.updateUserData(
            _initialUserData!.copyWith(email: _emailController.text),
          );
          break;
        case 3:
          userProvider.updateUserData(
            _initialUserData!.copyWith(diachi: _diachiController.text),
          );
          break;
        case 4:
          userProvider.updateUserData(
            _initialUserData!.copyWith(diachi: _describeController.text),
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
                            Container(
                              width: 260,
                              child: _isEditingList[0]
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
                                        maxLines: null,
                                      ),
                                    )
                                  : Text(
                                      _nameValue,
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                      softWrap: true,
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
                  'Thông tin công ty',
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
                        'Số điện thoại',
                        style: TextStyle(fontSize: 20),
                      ),
                      _isEditingList[1]
                          ? SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _phoneController,
                                enabled: _isEditingList[1],
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
                  _isEditingList[1]
                      ? GestureDetector(
                          onTap: () => _saveChanges(1),
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleEditing(1);
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
                      _isEditingList[2]
                          ? SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: _emailController,
                                enabled: _isEditingList[2],
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
                  _isEditingList[2]
                      ? GestureDetector(
                          onTap: () => _saveChanges(2),
                          child: const FaIcon(
                            FontAwesomeIcons.check,
                            color: Colors.green,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _toggleEditing(2);
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
                      _isEditingList[3]
                          ? SizedBox(
                              width: 230,
                              child: TextFormField(
                                controller: _diachiController,
                                enabled: _isEditingList[3],
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
                                      vertical: 13.0, horizontal: 10.0),
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
                        'Mô tả công ty',
                        style: TextStyle(fontSize: 20),
                      ),
                      Container(
                        width: 340,
                        height: 200,
                        child: _isEditingList[4]
                            ? SizedBox(
                                width: 240,
                                child: TextFormField(
                                  controller: _describeController,
                                  enabled: _isEditingList[4],
                                  keyboardType: TextInputType.streetAddress,
                                  autofocus: true,
                                  onChanged: (value) {
                                    setState(() {
                                      _describeValue = value;
                                    });
                                  },
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 14.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  maxLines: null,
                                ),
                              )
                            : Text(
                                _describeValue,
                                softWrap: true,
                              ),
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

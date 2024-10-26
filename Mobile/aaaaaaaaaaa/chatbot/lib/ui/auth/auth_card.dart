import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../../models/user.dart';
import '../share/dialog_utils.dart';

import 'auth_manager.dart';
import 'update_company.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with TickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
    'role': '',
    'userId': ''
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    // Kiểm tra và cập nhật giá trị role từ TabBar
    if (_authData['role']!.isEmpty) {
      if (_tabController.index == 0) {
        _authData['role'] = 'user';
      } else {
        _authData['role'] = 'company';
      }
    }
    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        await context.read<AuthManager>().login(_authData['email']!,
            _authData['password']!, _authData['role']!, context);
      } else {
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
              _authData['role']!,
              context,
              _navigateToProfilePage,
            );
      }
    } catch (error) {
      if (mounted) {
        showErrorDialog(
            context,
            (error is HttpException)
                ? error.toString()
                : 'Authentication failed');
      }
    }

    _isSubmitting.value = false;
  }

  void _navigateToProfilePage(UserData newUser) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileCompanyPage(
          userId: newUser.userId,
          email: newUser.email,
        ),
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() {
        _authMode = AuthMode.signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 00,
        right: 00,
        top: _authMode == AuthMode.login ? 200 : 200,
      ),
      height: _authMode == AuthMode.login ? 800 : 800,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  '${_authMode == AuthMode.login ? 'Đăng nhập' : 'Đăng kí'} ',
                  style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                _buildFields(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: _isSubmitting,
                      builder: (context, isSubmitting, child) {
                        if (isSubmitting) {
                          return const CircularProgressIndicator();
                        }
                        return _buildSubmitButton();
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildAuthModeSwitchButton(),
                  ],
                ),
                // if (_authMode == AuthMode.signup) _buildRoleTabBarView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFields() {
    if (_authMode == AuthMode.login) {
      return Column(
        children: [
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 20),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 20),
          _buildTabBar(),
          const SizedBox(height: 20),
          _buildEmailField(),
          const SizedBox(height: 20),
          _buildPasswordField(),
          const SizedBox(height: 20),
          _buildPasswordConfirmField(),
          const SizedBox(height: 20),
        ],
      );
    }
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: const Color.fromARGB(255, 173, 211, 242),
          borderRadius: BorderRadius.circular(15),
        ),
        controller: _tabController,
        tabs: const [
          Tab(text: 'Tài khoản ứng viên'),
          Tab(text: 'Tài khoản tuyển dụng')
        ],
        onTap: (index) {
          setState(() {
            if (index == 0) {
              _authData['role'] = 'user';
              print(_authData['role']);
            } else if (index == 1) {
              _authData['role'] = 'company';
              print(_authData['role']);
            }
          });
        },
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            '${_authMode == AuthMode.login ? 'Don\'t have an Account?' : 'Already have an Account? '}'),
        TextButton(
          onPressed: _switchAuthMode,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            textStyle: const TextStyle(
              color: Colors.amber,
            ),
          ),
          child: Text(
            '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'}',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.maxFinite,
      height: 55,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.blue,
          // padding: const EdgeInsets.symmetric(horizontal: 150.0, vertical: 8.0),
          textStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.titleLarge?.color,
          ),
        ),
        child: Text(
          _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      enabled: _authMode == AuthMode.signup,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.blue, // Màu của viền khi ô nhập liệu được chọn
            width: 2,
          ),
        ),
      ),
      obscureText: true,
      validator: _authMode == AuthMode.signup
          ? (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match!';
              }
              return null;
            }
          : null,
    );
  }

  Widget _selectRoll() {
    return SizedBox(
      width: double.infinity,
      child: Row(children: [
        Row(
          children: [
            Radio<String>(
              value: 'user',
              groupValue: _authData['role'],
              onChanged: (String? value) {
                setState(() {
                  _authData['role'] = value!;
                });
              },
            ),
            const Text('User'),
          ],
        ),
        Row(
          children: [
            Radio<String>(
              value: 'company',
              groupValue: _authData['role'],
              onChanged: (String? value) {
                setState(() {
                  _authData['role'] = value!;
                  print(_authData['role']);
                });
              },
            ),
            const Text('Company'),
          ],
        ),
      ]),
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.blue, // Màu của viền khi ô nhập liệu được chọn
            width: 2,
          ),
        ),
      ),
      obscureText: true,
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.length < 5) {
          return 'Password is too short!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['password'] = value!;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'E-Mail',
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Colors.blue, // Màu của viền khi ô nhập liệu được chọn
            width: 2,
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return 'Invalid email!';
        }
        return null;
      },
      onSaved: (value) {
        _authData['email'] = value!;
      },
    );
  }
}

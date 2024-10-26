import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../share/dialog_utils.dart';

import 'auth_manager.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({
    super.key,
  });

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  final _isSubmitting = ValueNotifier<bool>(false);
  final _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    _isSubmitting.value = true;

    try {
      if (_authMode == AuthMode.login) {
        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        await context.read<AuthManager>().signup(
              _authData['email']!,
              _authData['password']!,
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
        left: 15,
        right: 15,
        top: _authMode == AuthMode.login ? 200 : 150,
      ),
      height: _authMode == AuthMode.login ? 350 : 400,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(c),
              Text(
                '${_authMode == AuthMode.login ? 'Login' : 'Sign up'} ',
                style: const TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 20),
              _buildEmailField(),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 10),
              if (_authMode == AuthMode.signup) _buildPasswordConfirmField(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAuthModeSwitchButton(),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isSubmitting,
                    builder: (context, isSubmitting, child) {
                      if (isSubmitting) {
                        return const CircularProgressIndicator();
                      }
                      return _buildSubmitButton();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthModeSwitchButton() {
    return TextButton(
      onPressed: _switchAuthMode,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child:
          Text('${_authMode == AuthMode.login ? 'Create' : 'Login'} Account'),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _submit,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
        textStyle: TextStyle(
          color: Theme.of(context).primaryTextTheme.titleLarge?.color,
        ),
      ),
      child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      enabled: _authMode == AuthMode.signup,
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
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

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
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
      decoration: const InputDecoration(
        labelText: 'E-Mail',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2),
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

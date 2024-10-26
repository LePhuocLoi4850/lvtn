import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/http_exception.dart';
import '../shared/dialog_utils.dart';

import 'auth_manager.dart';

// enum AuthMode { signup, login }

// class AuthCard extends StatefulWidget {
//   const AuthCard({
//     super.key,
//   });

//   @override
//   State<AuthCard> createState() => _AuthCardState();
// }

// class _AuthCardState extends State<AuthCard> {
//   final GlobalKey<FormState> _formKey = GlobalKey();
//   AuthMode _authMode = AuthMode.login;
//   final Map<String, String> _authData = {
//     'email': '',
//     'password': '',
//   };
//   final _isSubmitting = ValueNotifier<bool>(false);
//   final _passwordController = TextEditingController();

//   Future<void> _submit() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }
//     _formKey.currentState!.save();

//     _isSubmitting.value = true;

//     try {
//       if (_authMode == AuthMode.login) {
//         // Log user in
//         await context.read<AuthManager>().login(
//               _authData['email']!,
//               _authData['password']!,
//             );
//       } else {
//         // Sign user up
//         await context.read<AuthManager>().signup(
//               _authData['email']!,
//               _authData['password']!,
//             );
//       }
//     } catch (error) {
//       if (mounted) {
//         showErrorDialog(
//             context,
//             (error is HttpException)
//                 ? error.toString()
//                 : 'Authentication failed');
//       }
//     }

//     _isSubmitting.value = false;
//   }

//   void _switchAuthMode() {
//     if (_authMode == AuthMode.login) {
//       setState(() {
//         _authMode = AuthMode.signup;
//       });
//     } else {
//       setState(() {
//         _authMode = AuthMode.login;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(0.0),
//         ),
//         elevation: 0.0,
//         color: Colors.transparent,
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   _buildEmailField(),
//                   _buildPasswordField(),
//                   if (_authMode == AuthMode.signup)
//                     _buildPasswordConfirmField(),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ValueListenableBuilder<bool>(
//                     valueListenable: _isSubmitting,
//                     builder: (context, isSubmitting, child) {
//                       if (isSubmitting) {
//                         return const CircularProgressIndicator();
//                       }
//                       return _buildSubmitButton();
//                     },
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   _buildAuthModeSwitchButton(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildAuthModeSwitchButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//             '${_authMode == AuthMode.login ? 'Don\'t have an Account? ' : 'Already have an Account? '}'),
//         TextButton(
//           onPressed: _switchAuthMode,
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4),
//             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             textStyle: TextStyle(
//               color: Colors.amber,
//             ),
//           ),
//           child: Text(
//             '${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'}',
//             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubmitButton() {
//     return ElevatedButton(
//       onPressed: _submit,
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//           side: BorderSide(color: Colors.black),
//         ),
//         elevation: 0,
//         backgroundColor: Color.fromARGB(255, 223, 223, 223),
//         padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//         textStyle: TextStyle(
//           color: Theme.of(context).primaryTextTheme.titleLarge?.color,
//         ),
//       ),
//       child: Text(
//         _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
//         style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//     );
//   }

//   Widget _buildPasswordConfirmField() {
//     return TextFormField(
//       enabled: _authMode == AuthMode.signup,
//       decoration: const InputDecoration(labelText: 'Confirm Password'),
//       obscureText: true,
//       validator: _authMode == AuthMode.signup
//           ? (value) {
//               if (value != _passwordController.text) {
//                 return 'Passwords do not match!';
//               }
//               return null;
//             }
//           : null,
//     );
//   }

//   Widget _buildPasswordField() {
//     return TextFormField(
//       decoration: const InputDecoration(labelText: 'Password'),
//       obscureText: true,
//       controller: _passwordController,
//       validator: (value) {
//         if (value == null || value.length < 5) {
//           return 'Password is too short!';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _authData['password'] = value!;
//       },
//     );
//   }

//   Widget _buildEmailField() {
//     return TextFormField(
//       decoration: const InputDecoration(labelText: 'E-Mail'),
//       keyboardType: TextInputType.emailAddress,
//       validator: (value) {
//         if (value!.isEmpty || !value.contains('@')) {
//           return 'Invalid email!';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _authData['email'] = value!;
//       },
//     );
//   }
// }

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
        // Log user in
        await context.read<AuthManager>().login(
              _authData['email']!,
              _authData['password']!,
            );
      } else {
        // Sign user up
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
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.signup ? 800 : 800,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.signup ? 620 : 620),
        width: deviceSize.width * 1,
        padding: const EdgeInsets.all(35.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  'YOU WANT TO FIND A JOB',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(
                  height: 40,
                ),
                _buildEmailField(),
                const SizedBox(
                  height: 20,
                ),
                _buildPasswordField(),
                const SizedBox(
                  height: 20,
                ),
                if (_authMode == AuthMode.signup)
                  Column(
                    children: [
                      _buildPasswordConfirmField(),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 40,
                ),
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
                  height: 20,
                ),
                _buildAuthModeSwitchButton(),
              ],
            ),
          ),
        ),
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
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          textStyle: TextStyle(
            color: Theme.of(context).primaryTextTheme.titleLarge?.color,
          ),
        ),
        child: Text(
          _authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPasswordConfirmField() {
    return TextFormField(
      enabled: _authMode == AuthMode.signup,
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(
                255, 130, 129, 129), // Màu của viền dưới mặc định
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

  Widget _buildPasswordField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Password',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 1.0),
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
      decoration: const InputDecoration(
        labelText: 'E-Mail',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(
                255, 130, 129, 129), // Màu của viền dưới mặc định
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

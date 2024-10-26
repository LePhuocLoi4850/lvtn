import 'package:chatbot/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../share/dialog_utils.dart';
import '../../user/users_manager.dart';

class EditUserScreen extends StatefulWidget {
  static const routeName = '/edit-user';

  EditUserScreen(
    UserData? userData, {
    super.key,
  }) {
    if (userData == null) {
      this.userData = UserData(
        userId: '',
        level: '',
        email: '',
        name: '',
        ngaysinh: '',
        phone: '',
        gioitinh: '',
        diachi: '',
        career: '',
        describe: '',
      );
    } else {
      this.userData = userData;
    }
  }
  late final UserData userData;

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _editForm = GlobalKey<FormState>();
  late UserData _editedUser;
  var _isLoading = false;

  @override
  void initState() {
    _editedUser = widget.userData;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                    buildPriceField(),
                    buildDescriptionField(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedUser.name,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(name: value);
      },
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedUser.phone,
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(phone: (value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedUser.email,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long';
        }
        return null;
      },
      onSaved: (value) {
        _editedUser = _editedUser.copyWith(email: value);
      },
    );
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final usersManager = context.read<UsersManager>();
      if (_editedUser.userId != null) {
        await usersManager.updateUser(_editedUser);
      }
    } catch (error) {
      if (mounted) {
        await showErrorDialog(context, 'Something went wrong');
      }
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}

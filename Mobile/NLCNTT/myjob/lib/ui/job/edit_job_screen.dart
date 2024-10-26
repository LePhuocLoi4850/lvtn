import 'package:myjob/models/company.dart';
import 'package:provider/provider.dart';
import '../../models/job.dart';
import 'package:flutter/material.dart';

import '../shared/dialog_utils.dart';
import 'job_manager.dart';

class EditJobScreen extends StatefulWidget {
  static const routeName = '/edit-Job';
  EditJobScreen(
    Job? job, {
    super.key,
  }) {
    if (job == null) {
      this.job = Job(
        id: null,
        title: '',
        description: '',
        imageUrl: '',
        luong: '',
        loai: '',
        soluong: '',
        lich: '',
        gioitinh: '',
        tuoi: '',
        hocvan: '',
        kinhnghiem: '',
        yeucaukhac: '',
        phucloi: '',
        company: Company.fromJson(job?.company.name as Map<String, dynamic>),
      );
    } else {
      this.job = job;
    }
  }
  late final Job job;
  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Job _editedJob;
  var _isLoading = false;

  // ignore: unused_element
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedJob = widget.job;
    _imageUrlController.text = _editedJob.imageUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
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

    // try {
    //   final jobManager = context.read<JobManager>();
    //   if (_editedJob.id != null) {
    //     jobManager.updateJob(_editedJob);
    //   }
    // } catch (error) {
    //   await showErrorDialog(context, 'Something went wrong.');
    // }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Job'),
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
                    buildJobPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedJob.title,
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
        _editedJob = _editedJob.copyWith(title: value);
      },
    );
  }

  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedJob.luong.toString(),
      decoration: const InputDecoration(labelText: 'Price'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a price.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith();
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedJob.description,
      decoration: const InputDecoration(labelText: 'Description'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(description: value);
      },
    );
  }

  Widget buildJobPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(imageUrl: value);
      },
    );
  }
}

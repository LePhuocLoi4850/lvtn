import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/job.dart';
import '../share/dialog_utils.dart';
import '../products/products_manager.dart';

class EditJobScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditJobScreen(
    Job? job, {
    super.key,
  }) {
    if (job == null) {
      this.job = Job(
        id: null,
        luong: 0,
        description: '',
        imageUrl: '',
        loai: '',
        soluong: '',
        lich: '',
        gioitinh: '',
        tuoi: '',
        hocvan: '',
        kinhnghiem: '',
        yeucaukhac: '',
        phucloi: '',
        diachi: '',
        title: '',
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
  final _titleController = TextEditingController();
  final _luongController = TextEditingController();
  final _loaiController = TextEditingController();
  final _soluongController = TextEditingController();
  final _diachiController = TextEditingController();
  final _lichController = TextEditingController();
  final _gioitinhController = TextEditingController();
  final _tuoiController = TextEditingController();
  final _hocvanController = TextEditingController();
  final _kinhnghiemController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yeucaukhacController = TextEditingController();
  final _phucloiController = TextEditingController();

  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Job _editedJob;
  var _isLoading = false;

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
    _titleController.text = _editedJob.title;
    _luongController.text = _editedJob.luong.toString();
    _loaiController.text = _editedJob.loai;
    _soluongController.text = _editedJob.soluong;
    _diachiController.text = _editedJob.diachi;
    _lichController.text = _editedJob.lich;
    _gioitinhController.text = _editedJob.gioitinh;
    _tuoiController.text = _editedJob.tuoi;
    _hocvanController.text = _editedJob.hocvan;
    _kinhnghiemController.text = _editedJob.kinhnghiem;
    _descriptionController.text = _editedJob.description;
    _yeucaukhacController.text = _editedJob.yeucaukhac;
    _phucloiController.text = _editedJob.phucloi;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _titleController.dispose();
    _luongController.dispose();
    _loaiController.dispose();
    _soluongController.dispose();
    _diachiController.dispose();
    _lichController.dispose();
    _gioitinhController.dispose();
    _tuoiController.dispose();
    _hocvanController.dispose();
    _kinhnghiemController.dispose();
    _descriptionController.dispose();
    _yeucaukhacController.dispose();
    _phucloiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit job'),
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
                    buildLuongField(),
                    buildLoaiField(),
                    buildSoLuongField(),
                    buildDiaChiField(),
                    buildLichField(),
                    buildGioiTinhField(),
                    buildTuoiField(),
                    buildHocVanField(),
                    buildKinhNghiemField(),
                    buildDescriptionField(),
                    buildYeuCauKhacField(),
                    buildPhucLoiField(),
                    buildJobPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: const InputDecoration(labelText: 'name'),
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

  TextFormField buildLuongField() {
    return TextFormField(
      controller: _luongController,
      decoration: const InputDecoration(labelText: 'Luong'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a Luong.';
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
        _editedJob = _editedJob.copyWith(luong: double.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
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
        _editedJob = _editedJob.copyWith(description: value);
      },
    );
  }

  TextFormField buildLoaiField() {
    return TextFormField(
      controller: _loaiController,
      decoration: const InputDecoration(labelText: 'Loại Hình Công Việc'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(loai: value);
      },
    );
  }

  TextFormField buildSoLuongField() {
    return TextFormField(
      controller: _soluongController,
      decoration: const InputDecoration(labelText: 'Số Lượng'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(soluong: value);
      },
    );
  }

  TextFormField buildDiaChiField() {
    return TextFormField(
      controller: _diachiController,
      decoration: const InputDecoration(labelText: 'Địa Chỉ Làm Việc'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(diachi: value);
      },
    );
  }

  TextFormField buildLichField() {
    return TextFormField(
      controller: _lichController,
      decoration: const InputDecoration(labelText: 'Lịch Làm Việc'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(lich: value);
      },
    );
  }

  TextFormField buildGioiTinhField() {
    return TextFormField(
      controller: _gioitinhController,
      decoration: const InputDecoration(labelText: 'Giới Tính'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(gioitinh: value);
      },
    );
  }

  TextFormField buildTuoiField() {
    return TextFormField(
      controller: _tuoiController,
      decoration: const InputDecoration(labelText: 'Độ Tuổi'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(tuoi: value);
      },
    );
  }

  TextFormField buildHocVanField() {
    return TextFormField(
      controller: _hocvanController,
      decoration: const InputDecoration(labelText: 'Học Vấn'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(hocvan: value);
      },
    );
  }

  TextFormField buildKinhNghiemField() {
    return TextFormField(
      controller: _kinhnghiemController,
      decoration: const InputDecoration(labelText: 'Kinh Nghiệm'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(kinhnghiem: value);
      },
    );
  }

  TextFormField buildYeuCauKhacField() {
    return TextFormField(
      controller: _yeucaukhacController,
      decoration: const InputDecoration(labelText: 'Yêu Cầu Khác'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(yeucaukhac: value);
      },
    );
  }

  TextFormField buildPhucLoiField() {
    return TextFormField(
      controller: _phucloiController,
      decoration: const InputDecoration(labelText: 'Phúc Lợi'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(phucloi: value);
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
          return 'Please enter a an image URL';
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
      final jobsManager = context.read<JobsManager>();
      if (_editedJob.id != null) {
        await jobsManager.updateJob(_editedJob);
      } else {
        await jobsManager.addJob(_editedJob);
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/career.dart';
import '../../models/job.dart';
import '../share/dialog_utils.dart';
import '../job/jobs_manager.dart';
import '../user_provider.dart';

class EditJobScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  EditJobScreen(
    Job? job, {
    super.key,
  }) {
    if (job == null) {
      this.job = Job(
        id: null,
        title: '',
        luong: 0,
        description: '',
        imageUrl: '',
        loai: '',
        soluong: 1,
        lich: '',
        gioitinh: '',
        tuoi: '',
        hocvan: '',
        kinhnghiem: '',
        nganhnghe: '',
        yeucaukhac: '',
        phucloi: '',
        diachi: '',
        creatorId: '',
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
  final _nganhngheController = TextEditingController();
  final _kinhnghiemController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _yeucaukhacController = TextEditingController();
  final _phucloiController = TextEditingController();

  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Job _editedJob;
  var _isLoading = false;
  // String? _selectedOption = '';
  CareerManager careerManager = CareerManager();
  Career? selectedCareer;

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
    _luongController.text = _editedJob.luong.toInt().toString();
    _loaiController.text = _editedJob.loai;
    _soluongController.text = _editedJob.soluong.toInt().toString();
    _diachiController.text = _editedJob.diachi;
    _lichController.text = _editedJob.lich;
    _gioitinhController.text = _editedJob.gioitinh;
    _tuoiController.text = _editedJob.tuoi;
    _hocvanController.text = _editedJob.hocvan;
    _nganhngheController.text = _editedJob.nganhnghe;
    _kinhnghiemController.text = _editedJob.kinhnghiem;
    _descriptionController.text = _editedJob.description;
    _yeucaukhacController.text = _editedJob.yeucaukhac;
    _phucloiController.text = _editedJob.phucloi;
    super.initState();
    final userProvider =
        Provider.of<UserProvider>(context, listen: false); // Get user provider
    final userId = userProvider.user?.userId; // Get userId from user provider
    _editedJob = widget.job.copyWith(creatorId: userId);
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
    _nganhngheController.dispose();
    _kinhnghiemController.dispose();
    _descriptionController.dispose();
    _yeucaukhacController.dispose();
    _phucloiController.dispose();
    super.dispose();
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
                              _editedJob = _editedJob.copyWith(
                                  nganhnghe:
                                      careerManager.allCareer[index].name);
                              _nganhngheController.text =
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Đăng tin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
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
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Tiêu đề tin tuyển dụng',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildTitleField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Ngành nghề đăng tuyển',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildCareerField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Số lượng cần tuyển',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildSoLuongField(),
                    buildJobPreview(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Mức lương',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildLuongField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Địa chỉ nơi làm việc',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildDiaChiField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Lịch làm việc',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildLichField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Giới tính',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildGioiTinhField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Độ tuổi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildTuoiField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Học vấn',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildHocVanField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Kinh nghiệm',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildKinhNghiemField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Mô tả công việc',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildDescriptionField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Yêu cầu khác',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildYeuCauKhacField(),
                    const SizedBox(height: 10),
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Phúc lợi',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildPhucLoiField(),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          child: ElevatedButton(
            onPressed: _saveForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Bo góc cho nút
              ),
            ),
            child: const Text(
              'Đăng Tin',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        hintText: 'Title',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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

  GestureDetector buildCareerField() {
    return GestureDetector(
      onTap: () {
        _showCareerBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _nganhngheController.text.isNotEmpty
                  ? _nganhngheController.text
                  : 'Loại Hình Công Việc',
              style: TextStyle(
                color: _nganhngheController.text.isNotEmpty
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : Colors.grey,
              ),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  TextFormField buildLoaiField() {
    return TextFormField(
      controller: _loaiController,
      decoration: const InputDecoration(hintText: 'Loại Hình Công Việc'),
      textInputAction: TextInputAction.next,
      autofocus: false,
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

  TextFormField buildLuongField() {
    return TextFormField(
      controller: _luongController,
      decoration: InputDecoration(
        hintText: 'Luong',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
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
      decoration: InputDecoration(
        hintText: 'description',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
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

  TextFormField buildSoLuongField() {
    return TextFormField(
      controller: _soluongController,
      decoration: InputDecoration(
        hintText: 'Số Lượng',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedJob = _editedJob.copyWith(soluong: double.parse(value!));
      },
    );
  }

  TextFormField buildDiaChiField() {
    return TextFormField(
      controller: _diachiController,
      decoration: InputDecoration(
        hintText: 'Địa chỉ làm việc',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Lịch làm việc',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Giới tính',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Độ tuổi',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Học vấn',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Khinh nghiệm',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Yêu cầu khác',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
      decoration: InputDecoration(
        hintText: 'Phúc lợi',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      textInputAction: TextInputAction.next,
      autofocus: false,
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
              borderRadius: BorderRadius.circular(15)),
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
      decoration: InputDecoration(
        hintText: 'Images',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
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

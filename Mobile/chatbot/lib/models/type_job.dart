class TypeJob {
  final String? id;
  final String name;
  bool isSelected;
  TypeJob({
    this.id,
    required this.name,
    this.isSelected = false,
  });

  TypeJob copyWith({
    String? id,
    String? name,
    bool? isSelected,
  }) {
    return TypeJob(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class TypeJobManager {
  final List<TypeJob> allTypeJob = [
    TypeJob(name: 'Dịch vụ ăn uống'),
    TypeJob(name: 'Kinh doanh'),
    TypeJob(name: 'Tư vấn'),
    TypeJob(name: 'Kế toán'),
    TypeJob(name: 'IT(Công nghệ thông tin)'),
  ];
  void selectTypeJob(String TypeJobName) {
    for (var TypeJob in allTypeJob) {
      if (TypeJob.name == TypeJobName) {
        TypeJob.isSelected = !TypeJob.isSelected;
      }
    }
  }
}

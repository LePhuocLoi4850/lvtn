class Candidate {
  final String? id;
  final String name;
  final String age;
  final String kinhnghiem;
  final String luong;
  final String chuyenmon;
  final String capbac;
  final String diadiem;
  final String nganhnghe;
  final String gioitinh;
  final String cvtruoc;
  final String hocvan;
  final String description;
  final String phone;
  final String bangkhac;

  const Candidate({
    this.id,
    required this.name,
    required this.age,
    required this.kinhnghiem,
    required this.luong,
    required this.chuyenmon,
    required this.capbac,
    required this.diadiem,
    required this.nganhnghe,
    required this.gioitinh,
    required this.cvtruoc,
    required this.hocvan,
    required this.description,
    required this.phone,
    required this.bangkhac,
    bool isFavorite = false,
  });

  Candidate copyWith({
    String? id,
    String? name,
    String? age,
    String? kinhnghiem,
    String? luong,
    String? chuyenmon,
    String? capbac,
    String? diadiem,
    String? nganhnghe,
    String? gioitinh,
    String? cvtruoc,
    String? hocvan,
    String? description,
    String? phone,
    String? bangkhac,
    bool? isFavorite,
  }) {
    return Candidate(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      kinhnghiem: kinhnghiem ?? this.kinhnghiem,
      luong: luong ?? this.luong,
      chuyenmon: chuyenmon ?? this.chuyenmon,
      capbac: capbac ?? this.capbac,
      diadiem: diadiem ?? this.diadiem,
      nganhnghe: nganhnghe ?? this.nganhnghe,
      gioitinh: gioitinh ?? this.gioitinh,
      cvtruoc: cvtruoc ?? this.cvtruoc,
      hocvan: hocvan ?? this.hocvan,
      description: description ?? this.description,
      phone: phone ?? this.phone,
      bangkhac: bangkhac ?? this.bangkhac,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'kinhnghiem': kinhnghiem,
      'luong': luong,
      'chuyenmon': chuyenmon,
      'capbac': capbac,
      'diadiem': diadiem,
      'nganhnghe': nganhnghe,
      'gioitinh': gioitinh,
      'cvtruoc': cvtruoc,
      'hocvan': hocvan,
      'description': description,
      'phone': phone,
      'bangkhac': bangkhac,
    };
  }

  static Candidate fromJson(Map<String, dynamic> json) {
    return Candidate(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      kinhnghiem: json['kinhnghiem'],
      luong: json['luong'],
      chuyenmon: json['chuyenmon'],
      capbac: json['capbac'],
      diadiem: json['diadiem'],
      nganhnghe: json['nganhnghe'],
      gioitinh: json['gioitinh'],
      cvtruoc: json['cvtruoc'],
      hocvan: json['hocvan'],
      description: json['description'],
      phone: json['phone'],
      bangkhac: json['bangkhac'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}

class PemilihModel {
  int? id;
  String? nik, nama, noHp, jk, tglData, koordinat, photoName;

  PemilihModel(
      {this.id,
      this.nik,
      this.nama,
      this.noHp,
      this.jk,
      this.tglData,
      this.koordinat,
      this.photoName});

  factory PemilihModel.fromJson(Map<String, dynamic> json) {
    return PemilihModel(
        id: json['id'],
        nik: json['nik'],
        nama: json['nama'],
        noHp: json['noHp'],
        jk: json['jk'],
        tglData: json['tglData'],
        koordinat: json['koordinat'],
        photoName: json['photoName']);
  }
}

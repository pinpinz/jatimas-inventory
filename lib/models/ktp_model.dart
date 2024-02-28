import 'dart:io';

class KtpModel {
  String? nik;
  String? namaLengkap;
  String? tempatLahir;
  DateTime? tanggalLahir;
  String? jenisKelamin;
  String? golDarah;
  String? alamatFull;
  String? alamat;
  String? rtrw;
  String? kelDesa;
  String? kecamatan;
  String? agama;
  String? statusPerkawinan;
  String? pekerjaan;
  String? kewarganegaraan;
  String? berlakuHingga;
  List<File>? ktpImages;

  KtpModel(
      {this.nik,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.jenisKelamin,
      this.golDarah,
      this.alamatFull,
      this.alamat,
      this.rtrw,
      this.kelDesa,
      this.kecamatan,
      this.agama,
      this.statusPerkawinan,
      this.pekerjaan,
      this.kewarganegaraan,
      this.berlakuHingga,
      this.ktpImages});
}

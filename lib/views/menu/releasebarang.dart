import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// import 'package:scanerx/dataRak.dart';
// import 'package:scanerx/dataServerDetil.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

class ScanRelease extends StatefulWidget {
  const ScanRelease({Key? key}) : super(key: key);

  @override
  _ScanReleaseState createState() => _ScanReleaseState();
}

var statusSimpan = "";
var pathGambar = 'assets/images/scanner.png';
var barcodeScanRes = "";
var QRHapus = "";
var kodeHapus = "";

final textBox1 = TextEditingController();
final textBox2 = TextEditingController();
final textBox3 = TextEditingController();
final textBox4 = TextEditingController();

var dataRespon;
var dataList;

FocusNode node1 = FocusNode();
FocusNode node2 = FocusNode();
FocusNode node3 = FocusNode();
FocusNode node4 = FocusNode();

List<String> kodeBarangScan = [];
List<String> NamaBarangScan = [];
List<String> QRBarangScan = [];
List<String> kodeBarangRekap = [];
List<String> NamaBarangRekap = [];
List<int> BarangQty = [];

int urut = 0;

class _ScanReleaseState extends State<ScanRelease> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dateController1.text = "date1";
    dateController2.text = "dare2";
  }

  // simpan() async {
  //   try {
  //     showLoaderDialog(context);

  //     BaseOptions options = new BaseOptions(
  //       connectTimeout: Duration(milliseconds: 3000),
  //       receiveTimeout: Duration(milliseconds: 3000),
  //     );
  //     var dio = Dio(options);
  //     isKoneksiPutus = false;
  //     statusSimpan = "gagal";
  //     FormData formData = new FormData.fromMap({
  //       "noDoc": textBox2.text,
  //       "petugas": textBox3.text,
  //       "rak": textBox4.text,
  //       "kodeBarang": dataList[4],
  //       "namaBarang": dataList[5],
  //       "QRbarang": dataList[1],
  //     });

  //     Response response = await dio.post(
  //       ip + "simpanScanSO.php", //endpoint api Login
  //       data: formData,
  //       options: Options(contentType: Headers.jsonContentType),
  //     );
  //     List<dynamic> kembalian = jsonDecode(response.data);

  //     dataRespon = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       Navigator.pop(context);
  //       statusSimpan = dataRespon[0]["status"];
  //     }
  //   } on DioError catch (e) {
  //     Navigator.pop(context);
  //     isKoneksiPutus = true;
  //   }
  // }

  // hapus() async {
  //   try {
  //     showLoaderDialog(context);

  //     BaseOptions options = new BaseOptions(
  //       connectTimeout: 3000,
  //       receiveTimeout: 3000,
  //     );
  //     var dio = Dio(options);
  //     isKoneksiPutus = false;
  //     statusSimpan = "gagal";
  //     FormData formData = new FormData.fromMap({
  //       "noDoc": textBox2.text,
  //       "petugas": textBox3.text,
  //       "rak": textBox4.text,
  //       "QRbarang": QRHapus,
  //     });

  //     Response response = await dio.post(
  //       ip + "hapusScanSO.php", //endpoint api Login
  //       data: formData,
  //       options: Options(contentType: Headers.jsonContentType),
  //     );
  //     List<dynamic> kembalian = jsonDecode(response.data);

  //     dataRespon = jsonDecode(response.data);

  //     if (response.statusCode == 200) {
  //       Navigator.pop(context);
  //     }
  //   } on DioError catch (e) {
  //     Navigator.pop(context);
  //     isKoneksiPutus = true;
  //   }
  // }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  prosesSimpan(String x) async {
    Vibrate.vibrate();

    final Iterable<Duration> pauses1 = [];

    final Iterable<Duration> pauses2 = [
      const Duration(milliseconds: 300),
      const Duration(milliseconds: 300),
    ];

    if (textBox2.text == "") {
      Vibrate.vibrateWithPauses(pauses2);
      await Pesan(context, "Dokumen Belum diisi");
      FocusScope.of(context).requestFocus(node2);
    } else {
      if (textBox3.text == "") {
        Vibrate.vibrateWithPauses(pauses2);
        await Pesan(context, "Petugas Belum diisi");
        FocusScope.of(context).requestFocus(node3);
      } else {
        if (textBox3.text == "") {
          Vibrate.vibrateWithPauses(pauses2);
          await Pesan(context, "Rak/Troly Belum diisi");
          FocusScope.of(context).requestFocus(node4);
        } else {
          // try {
          //   dataList = x.split("~");

          //   await simpan();
          //   if (isKoneksiPutus) {
          //     Vibrate.vibrateWithPauses(pauses2);
          //     pathGambar = 'aset/gambar/error.png';
          //     namaBarang = "Gagal konek ke Server";
          //   } else {
          //     if (statusSimpan == "sukses") {
          //         Vibrate.vibrateWithPauses(pauses1);
          //       pathGambar = 'aset/gambar/aman.jpg';
          //       prosesScaning();
          //     } else {
          //       Vibrate.vibrateWithPauses(pauses2);
          //       pathGambar = 'aset/gambar/error.png';
          //       namaBarang = "QR sudah pernah discan";
          //     }
          //   }
          // } catch (e) {
          //     Vibrate.vibrateWithPauses(pauses2);
          //   await Pesan(context, "QR tidak bisa diidentifikasi");
          //   Navigator.pop(context);
          // }
          setState(() {});
        }
      }
    }
  }

  prosesScaning() async {
    // kodeQR = dataList[1];

    // namaBarang = dataList[5];

    // kodeBarangScan.add(dataList[4]);
    // NamaBarangScan.add(dataList[5]);
    // QRBarangScan.add(dataList[1]);

    // urut = kodeBarangRekap.indexWhere((item) => item == dataList[4]);

    // if (urut == -1) {
    //   kodeBarangRekap.add(dataList[4]);
    //   NamaBarangRekap.add(dataList[5]);
    //   BarangQty.add(1);
    // } else {
    //   BarangQty[urut] = BarangQty[urut] + 1;
    // }
  }

  focusRak() {
    FocusScope.of(context).requestFocus(node4);
  }

  focusDoc() {
    FocusScope.of(context).requestFocus(node2);
  }
  //komponen untuk datepicker

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
  final pencarianControler = TextEditingController();

  Future<Null> _selectDate(
      BuildContext context, TextEditingController datepick) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        datepick.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    List<String> list = List.generate(10, (index) => "$index");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Release Barang",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 70, 70, 70),
      ),
      backgroundColor: Colors.white,
      body: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        // onLoading: _onLoading,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 223, 223, 224),
                        border: Border.all(
                            color: Color.fromARGB(255, 243, 242, 242)),
                      ),
                      // margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                      child: TextFormField(
                        style: TextStyle(fontSize: 14),
                        focusNode: node3,
                        onFieldSubmitted: (value) async {
                          FocusScope.of(context).requestFocus(node4);
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Petugas',
                          border: InputBorder.none,
                        ),
                        controller: textBox3,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.43,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 223, 223, 224),
                        border: Border.all(
                          color: Color.fromARGB(255, 223, 223, 224),
                        ),
                      ),
                      // margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                      child: TextFormField(
                        focusNode: node4,
                        style: TextStyle(fontSize: 14),
                        onFieldSubmitted: (value) async {
                          FocusScope.of(context).requestFocus(node1);
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          hintText: 'Pengiriman',
                          border: InputBorder.none,
                        ),
                        controller: textBox4,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: IconButton(
                  onPressed: () async {
                    // if (idxPencarian == "Scan") {
                    //   idxPencarian = "Text";
                    // } else {
                    //   idxPencarian = "Scan";
                    // }
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.new_releases_rounded,
                    color: Colors.blue,
                  ),
                  // icon: Image.asset(
                  //   pathGambar,
                  // ),
                  iconSize: (MediaQuery.of(context).size.height * (13 / 100)),
                ),
              ),
            ]),
      ),
      bottomNavigationBar: Container(
        height: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
            height: 50,
            color: Colors.blueGrey,
            child: const Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Nama barang",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Row(children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(left: 15, right: 0, bottom: 5, top: 5),
              child: MaterialButton(
                onPressed: () async {
                  // idxRekap = "detil";

                  setState(() {});
                },
                child: const Text("<< Detil >>",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                color: Color.fromARGB(255, 207, 207, 207),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.only(left: 16, right: 16),
              ),
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 5),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {});
                  },
                  child: const Text("<< EXPAND >>",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 12)),
                  color: Color.fromARGB(255, 207, 207, 207),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.only(left: 12, right: 16),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 0, right: 15, bottom: 5, top: 5),
              child: MaterialButton(
                onPressed: () async {
                  setState(() {});
                },
                child: const Text("<< Rekap >>",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 12)),
                color: Color.fromARGB(255, 207, 207, 207),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.only(left: 16, right: 16),
              ),
            ),
          ])
        ]),
      ),
    );
  }
}

PesanYaTidak(context, title, type) {}

Pesan(context, title) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          height: 300,
          width: 300,
          child: Material(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    title.toString(),
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.only(
                      left: 60, right: 60, bottom: 10, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Kembali",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16)),
                    color: Color.fromARGB(255, 53, 48, 99),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

// showLoaderDialog(BuildContext context) {
//   AlertDialog alert = AlertDialog(
//     content: Row(
//       children: [
//         const CircularProgressIndicator(),
//         Container(
//             margin: const EdgeInsets.only(left: 7),
//             child: const Text("Loading...")),
//       ],
//     ),
//   );
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }

import 'dart:convert';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jatimasinventory/views/home/home.dart';

// import 'package:scanerx/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

import 'releasepicking.dart';

class cobaScan extends StatefulWidget {
  const cobaScan({Key? key}) : super(key: key);

  @override
  _cobaScanState createState() => _cobaScanState();
}

FlutterTts flutterTts = FlutterTts();

var idTrans = "";
var ketStatusQR = "";
var isiLokasi = "gudang jatimas";

var cariRak;
var barcodeScanRes = "";
var flag;
var info;

final textBox1 = TextEditingController();
final textBox2 = TextEditingController();
final textBox3 = TextEditingController();
final textBox4 = TextEditingController();
final textBox5 = TextEditingController();
final textBox6 = TextEditingController();

var isError = false;

FocusNode node1 = FocusNode();
FocusNode node2 = FocusNode();

AudioPlayer player = AudioPlayer();

var barangScan = [];
var barangScanRekap = [];
var ip = "182.16.173.90:3030/inv/";

var allMenuView = true;

int urut = 0;

class _cobaScanState extends State<cobaScan> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dateController1.text = "date1";
    dateController2.text = "setDate2";

    textBox2.text = "periodeSO";
    textBox3.text = "username";

    urut = 0;
    flag = "0";
    textBox4.text = "";
    textBox5.text = "";

    barangScan = [];
    barangScanRekap = [];

    info = "Scan Lokasi Anda (pastikan remark diisi)";
    speak("kamu sudah masuk di menu picking", 0.5);
  }

  speak(String text, rate) async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.speak(text);
  }

  var isKoneksiPutus = true;
  simpan(String kodeB, String namaB, String QRB, String expB) async {
    try {
      BaseOptions options = new BaseOptions(
        connectTimeout: Duration(milliseconds: 15 * 1000),
        receiveTimeout: Duration(milliseconds: 15 * 1000),
      );
      var dio = Dio(options);
      isKoneksiPutus = false;

      // FormData formData = new FormData.fromMap({
      //   "idTrans": "textBox5.text",
      //   "noDoc": "textBox2.text",
      //   "idUser": "kodeUser",
      //   "petugas": "textBox3.text",
      //   "rak": "textBox4.text",
      //   "kodeBarang": "kodeB",
      //   "namaBarang": "namaB",
      //   "QRbarang": "QRB",
      //   "exp": "expB",
      //   "flag": "flag",
      //   "remark": "textBox6.text",
      // });

      // showLoaderDialog(context);

      Response response = await dio.post(
        ip + "scanPicking.php", //endpoint api Login
        // data: formData,
        options: Options(contentType: Headers.jsonContentType),
      );

      var dataRespon = jsonDecode(response.data);

      if (response.statusCode == 200) {
        // Navigator.pop(context);

        // statusSimpan = dataRespon[0]["status"];
        // idTrans = dataRespon[0]["idTrans"];
        // ketStatusQR = dataRespon[0]["keterangan"];

        return [dataRespon, false];
      }
    } on DioError {
      // Navigator.pop(context);
      return [[], true];
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    // await segarRak();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  final Iterable<Duration> pauses2 = [
    const Duration(milliseconds: 300),
  ];
  var idxExpand = "UP";
  persiapanScan(String x, bool y) async {
    var dataList;
    var pancing = [];

    if (isError == false) {
      idxExpand = "UP";
      allMenuView = false;
      if (textBox6.text == "-") {
        speak("Silakan isi Remark Anda", 0.5);
        idxExpand = "DOWN";

        FocusScope.of(context).requestFocus(node2);
        setState(() {});
      } else {
        if (info == "Scan Lokasi Anda (pastikan remark diisi)") {
          try {
            dataList = x.split("~");
            if (dataList.length == 2) {
              textBox4.text = dataList[1];
              isiLokasi = x;
              info = "Scan QR Barang Anda";

              speak("Silakan Scan Barang Anda", 0.5);
              setState(() {});
            } else {
              Vibrate.vibrate();

              info = "Scan Lokasi Anda (pastikan remark diisi)";
              speak("Format QR Tidak dikenali satu", 0.5);
            }
          } catch (e) {
            Vibrate.vibrate();

            info = "Scan Lokasi Anda (pastikan remark diisi)";
            speak("Format QR Tidak dikenali dua", 0.5);
          }
        } else {
          try {
            if (x.length == 13) {
              x = "x0~Non QR~x2~x3~" + x + "~Barang Non QR~4040-01-01~";
            }

            dataList = x.split("~");
            pancing = dataList[1];

            if ((pancing.length == 14 ||
                    pancing == "Non QR" ||
                    pancing.length == 12) &&
                dataList.length == 8) {
              await prosesSimpan(x);

              if (y == true) {
                String xx = await FlutterBarcodeScanner.scanBarcode(
                    "#ff6666", "Cancel", true, ScanMode.DEFAULT);
                await persiapanScan(xx, true);
              }
            } else {
              Vibrate.vibrate();

              info = "Pastikan yang discan QR eloda";
              speak("Format QR Tidak dikenali tiga", 0.5);
            }
          } catch (e) {
            Vibrate.vibrate();

            info = "Pastikan yang discan QR eloda";
            speak("Format QR Tidak dikenali empat", 0.5);
            await prosesSimpan(x);
          }
        }
      }
    }

    setState(() {});
  }

  prosesSimpan(String x) async {
    var dataList;

    if (textBox4.text == "") {
      Vibrate.vibrate();

      info = "Rak/Troly Belum diisi";
      speak("Isian masih Kosong", 0.5);
    } else {
      try {
        dataList = x.split("~");

        var statusQR =
            await simpan(dataList[4], dataList[5], dataList[1], dataList[6]);

        // uji coba
        isKoneksiPutus = false;
        statusSimpan = "sukses";

        if (statusQR[1]) {
          Vibrate.vibrate();

          info = "Gagal konek ke Server";
          speak("gagal konek server", 0.5);
        } else if (statusQR[0][0]["status"] == "sukses") {
          flag = "1";

          textBox5.text = statusQR[0][0]["idTrans"];

          await prosesScaning(
            dataList[1],
            dataList[4],
            dataList[5],
            dataList[6],
          );

          final Exp = DateTime.parse(dataList[6]);
          final tglSkg = DateTime.now();

          if (tglSkg.difference(Exp).inDays > 40) {
            speak("Tanggal kadaluarsa Pendek terdeteksi", 1);
          } else {
            speak(barangScan.length.toString(), 0.3);
          }
        } else {
          Vibrate.vibrate();

          info = statusQR[0][0]["status"];
          speak(statusQR[0][0]["status"].toString(), 0.5);
        }
      } catch (e) {
        Vibrate.vibrate();
        isError = true;
        await Pesan(context, e.toString());
        isError = false;
      }
    }
    setState(() {});
  }

  var kodeQR;
  prosesScaning(
    String QRB,
    String kodeB,
    String namaB,
    String expB,
  ) async {
    kodeQR = QRB;

    info = namaB;

    urut = barangScanRekap
        .indexWhere((barang) => barang['kodeBarang'] == kodeB.toString());

    if (urut == -1) {
      barangScanRekap.add(
        {
          'kodeBarang': kodeB.toString(),
          'namaBarang': namaB.toString(),
          'qty': "1",
        },
      );
    } else {
      barangScanRekap[urut]["qty"] =
          (int.parse(barangScanRekap[urut]["qty"]) + 1).toString();
    }

    barangScan.add(
      {
        'kodeBarang': kodeB,
        'namaBarang': namaB,
        'exp': expB,
        'qr': QRB,
      },
    );
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

  backToMenu() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  var idxRekap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        // onLoading: _onLoading,
        child: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: allMenuView == true
          //         ? AssetImage("aset/gambar/header.jpg")
          //         : AssetImage("aset/gambar/polos.jpg"),
          //     fit: BoxFit.fitWidth,
          //     alignment: Alignment.topCenter,
          //   ),
          // ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (allMenuView == true) ...[
                if (MediaQuery.of(context).size.height > 700) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.width * (12 / 100),
                  ),
                ] else ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.width * (9 / 100),
                  ),
                ],
                Row(
                  children: [
                    Spacer(),
                    Text("Scan Bebas   ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 41, 40, 40),
                            fontWeight: FontWeight.w700,
                            fontSize: 17)),
                    IconButton(
                      iconSize: 30,
                      // icon: Image.asset("aset/gambar/informasi.png"),
                      icon: Icon(Icons.abc),
                      onPressed: () async {
                        if (idxExpand == "UP") {
                          idxExpand = "DOWN";
                        } else {
                          idxExpand = "UP";
                        }

                        // await segarRak();

                        setState(() {});
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text("View",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 49, 49, 49),
                                fontWeight: FontWeight.w700,
                                fontSize: 10)),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          iconSize: 30,
                          // icon: Image.asset("aset/gambar/1901898.png"),
                          icon: Icon(Icons.abc),
                          onPressed: () async {
                            await PesanYaTidak(
                                context, " Mau Keluar \nYakin?", "back");
                          },
                        ),
                        Text("Exit",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 49, 49, 49),
                                fontWeight: FontWeight.w700,
                                fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ] else ...[
                SizedBox(
                  height: MediaQuery.of(context).size.width * (12 / 100),
                ),
              ],
              if (idxExpand == "DOWN") ...[
                Container(
                  margin: EdgeInsets.only(
                      top: 30,
                      left: MediaQuery.of(context).size.width * (12 / 100),
                      right: MediaQuery.of(context).size.width * (12 / 100)),
                  child: Column(
                    children: [],
                  ),
                ),
                Spacer(),
              ] else ...[
                Container(
                  margin: EdgeInsets.only(
                      top: 10,
                      left: MediaQuery.of(context).size.width * (5 / 100),
                      right: MediaQuery.of(context).size.width * (5 / 100)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Text(
                              "ID : " +
                                  textBox5.text +
                                  "     Lokasi : " +
                                  textBox4.text,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 49, 49, 49),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Info ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 49, 49, 49),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (80 / 100),
                            child: AutoSizeText(info,
                                maxLines: 2,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 214, 21, 21),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (10 / 100),
                            child: Text("#",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 49, 49, 49),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (58 / 100),
                            child: Text("Nama Barang",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 49, 49, 49),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13)),
                          ),
                          if (idxRekap == "detil") ...[
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (20 / 100),
                              child: Text("QR",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 49, 49, 49),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13)),
                            ),
                          ] else ...[
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (20 / 100),
                              child: Text("Qty",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 49, 49, 49),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13)),
                            ),
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
                if (idxRekap == "detil") ...[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * (5 / 100),
                          right: MediaQuery.of(context).size.width * (5 / 100)),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 7),
                          itemCount: barangScan.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(top: 0, bottom: 2),
                              child: InkWell(
                                onTap: () async {},
                                splashColor: Colors.red,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          (10 / 100),
                                      child: Text((index + 1).toString(),
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 49, 49, 49),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          (50 / 100),
                                      child: Text(
                                          barangScan[index]["namaBarang"],
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 49, 49, 49),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          (27 / 100),
                                      child: Text(barangScan[index]["qr"],
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 49, 49, 49),
                                              fontWeight: FontWeight.normal,
                                              fontSize: 10)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * (5 / 100),
                          right: MediaQuery.of(context).size.width * (5 / 100)),
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 7),
                          itemCount: barangScanRekap.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              color: urut == index
                                  ? Color.fromARGB(255, 224, 228, 247)
                                  : Colors.transparent,
                              padding: EdgeInsets.only(top: 0, bottom: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        (10 / 100),
                                    child: Text((index + 1).toString(),
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 49, 49, 49),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        (58 / 100),
                                    child: Text(
                                        barangScanRekap[index]["namaBarang"],
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 49, 49, 49),
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        (20 / 100),
                                    child:
                                        Text(
                                            barangScanRekap[index]["qty"]
                                                .toString(),
                                            textAlign: TextAlign.right,
                                            style:
                                                TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 49, 49, 49),
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 10)),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                ],
                Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          iconSize: 30,
                          // icon: Image.asset("aset/gambar/230759.png"),
                          icon: Icon(Icons.abc),
                          onPressed: () async {},
                        ),
                        Text("Data",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 49, 49, 49),
                                fontWeight: FontWeight.w700,
                                fontSize: 10)),
                      ],
                    ),
                    Spacer(),
                    Text(
                        "- Total Scan : " +
                            barangScan.length.toString() +
                            ' - ',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 49, 49, 49),
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                    Spacer(),
                    Column(
                      children: [
                        IconButton(
                          iconSize: 30,
                          // icon: Image.asset("aset/gambar/1508442.png"),
                          icon: Icon(Icons.abc),
                          onPressed: () async {
                            await PesanYaTidak(
                                context, " Ganti RAK \nYakin?", "ganti_rak");
                          },
                        ),
                        Text("Selesai",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 49, 49, 49),
                                fontWeight: FontWeight.w700,
                                fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ],
              Container(
                margin: EdgeInsets.only(top: 5),
                height: 60,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("aset/gambar/footer.jpg"),
                //     fit: BoxFit.cover,
                //     alignment: Alignment.topCenter,
                //   ),
                // ),
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 30,
                      // icon: Image.asset("aset/gambar/5208563.png"),
                      icon: Icon(Icons.abc),
                      onPressed: () async {
                        if (allMenuView == true) {
                          allMenuView = false;
                        } else {
                          allMenuView = true;
                        }
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 223, 223, 224),
                          border: Border.all(
                              color: Color.fromARGB(255, 243, 242, 242)),
                        ),
                        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: TextFormField(
                          style: TextStyle(fontSize: 14),
                          onFieldSubmitted: (value) async {
                            if (value == "99") {
                              value = isiLokasi;
                            }

                            if (value == "88") {
                              await cariLokasiRak(context, "-");

                              value = '~' + isiLokasi.toString();
                            }

                            if (flag == "0") {
                              await persiapanScan(value, false);
                            } else {
                              persiapanScan(value, false);
                            }

                            textBox1.clear();
                            FocusScope.of(context).requestFocus(node1);
                          },
                          focusNode: node1,
                          obscureText: false,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            hintText: 'Input QR disini',
                            border: InputBorder.none,
                          ),
                          controller: textBox1,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    if (MediaQuery.of(context).size.height > 700) ...[
                      IconButton(
                        iconSize: 40,
                        // icon: Image.asset("aset/gambar/678090.png"),
                        icon: Icon(Icons.abc),
                        onPressed: () async {
                          // FlutterBarcodeScanner.getBarcodeStreamReceiver(
                          //         '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
                          //     .listen((barcode) => print(barcode));

                          barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#ff6666", "Cancel", true, ScanMode.DEFAULT);

                          // barcodeScanRes =
                          //     "3CB3E498-2AE9-EC11-8426-D4AE52B321C4~QR220901002562~9FADBDDA-B551-4CD9-B177-F536F9EBF367~E09ACE34-4CA2-4C66-8C41-0FB911BD7408~9930109140~BND ROTI BGR WIJEN 6 BJ @18PK/BOX~2022-12-10~";

                          // barcodeScanRes =
                          //     "79633683-18FE-4D23-AC23-0CA6624D1652~K02.1";

                          await persiapanScan(barcodeScanRes, true);
                        },
                      ),
                    ],
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  PesanYaTidak(context, title, type) {
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
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      title.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 56, 56, 56)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            IconButton(
                              iconSize: 80,
                              // icon: Image.asset("aset/gambar/11633050.png"),
                              icon: Icon(Icons.abc),
                              onPressed: () async {
                                if (type == "ganti_rak") {
                                  if (textBox4.text == "") {
                                    info =
                                        "Scan Lokasi Anda (pastikan remark diisi)";
                                    speak("Lokasi Anda Belum discan", 0.5);
                                  } else {
                                    flag = "0";
                                    urut = 0;
                                    textBox4.text = "";
                                    textBox5.text = "";
                                    barangScan = [];
                                    barangScanRekap = [];

                                    info =
                                        "Scan Lokasi Anda (pastikan remark diisi)";
                                    speak("Poses Berhasil", 0.5);

                                    speak("Silakan Scan Lokasi Anda", 0.5);
                                  }
                                }
                                if (type == "back") {
                                  Navigator.pop(context);
                                }
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 80,
                              // icon: Image.asset("aset/gambar/11633077.png"),
                              icon: Icon(Icons.abc),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
                        player.stop();
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

  cariLokasiRak(context, title) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            height: 420,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Material(
                //   child: IconButton(
                //     onPressed: () async {},
                //     icon: Image.asset(
                //       'aset/gambar/4695220.png',
                //     ),
                //     iconSize: 70,
                //   ),
                // ),
                Container(
                  height: 400,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 7),
                    itemCount: cariRak.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 20, right: 20),
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 80, 79, 79),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () async {
                              isiLokasi = cariRak[index]["namaRak"].toString();
                              Navigator.pop(context);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: IconButton(
                                    onPressed: () async {},
                                    // icon: Image.asset(
                                    //   'aset/gambar/9350694.png',
                                    // ),
                                    icon: Icon(Icons.abc),
                                    iconSize: 30,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Container(
                                    //   margin: EdgeInsets.only(
                                    //       left: 15, top: 8, bottom: 5),
                                    //   width: MediaQuery.of(context).size.width *
                                    //       (30 / 100),
                                    //   child: Text('',
                                    //       style: TextStyle(
                                    //           color: const Color.fromARGB(
                                    //               255, 49, 49, 49),
                                    //           // fontWeight: FontWeight.w700,
                                    //           fontSize: 13)),
                                    // ),
                                    Container(
                                      margin: EdgeInsets.only(left: 15),
                                      width: MediaQuery.of(context).size.width *
                                          (35 / 100),
                                      child: Text(
                                          cariRak[index]["namaRak"].toString(),
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 49, 49, 49),
                                              // fontWeight: FontWeight.w700,
                                              fontSize: 12)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

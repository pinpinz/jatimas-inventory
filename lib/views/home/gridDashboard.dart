import 'package:jatimasinventory/views/menu/releasepicking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/image_app.dart';
import '../routes.dart';

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  String nav;
  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img,
      required this.nav});
}

class GridDashboard extends StatelessWidget {
  Items item1 = Items(
    title: "Picking",
    subtitle: "Picking Menu",
    event: "3 Events",
    img: "scanner.png",
    nav: Routes.scanpicking,
  );

  Items item2 = Items(
    title: "Release",
    subtitle: "Release Inventory",
    event: "4 Items",
    img: "todo.png",
    nav: Routes.releasepicking,
  );
  Items item3 = Items(
      title: "Retur",
      subtitle: "return inventory",
      event: "",
      img: "map.png",
      nav: Routes.returpicking);
  Items item4 = Items(
      title: "Logout",
      subtitle: "Log Out Account",
      event: "",
      img: "user.png",
      nav: Routes.cobascan);

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 246, 205, 81),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, data.nav);
                // Navigator.pushNamed(context, data.nav);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // ImageApp(data.img, width: 42),
                  ImageApp(
                    data.img,
                    width: 72,
                  ),
                  SizedBox(height: 14),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

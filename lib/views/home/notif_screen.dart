import 'package:flutter/material.dart';

import '../../services/api/auth_api.dart';
import '../../utils/colors.dart';
import '../../widgets/sliver_navbar.dart';
import '../../widgets/text_app.dart';

class NotifScreen extends StatefulWidget {
  const NotifScreen({Key? key}) : super(key: key);

  @override
  State<NotifScreen> createState() => _NotifScreenState();
}

class _NotifScreenState extends State<NotifScreen> {
  final _authApi = AuthApi();
  List<Map<String, dynamic>> _notif = [];
  String _message = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getList();
    });
  }

  @override
  void dispose() {
    /** */

    super.dispose();
  }

  Future<void> getList() async {
    await _authApi.getNotif().then((res) {
      res.fold(
        (error) {},
        (response) {
          if (response.code == 200) {
            setState(() {
              if (response.data != null) {
                _notif = (response.data as List)
                    .map((item) => item as Map<String, dynamic>)
                    .toList();
              }

              _message = response.message.toString();
            });
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverNavBar(
            title: 'Notification',
            color: ColorApp.dark,
            colorOffset: ColorApp.dark,
            bgColor: ColorApp.light,
            bgColorOffset: ColorApp.light,
          ),
          if (_notif.isEmpty && _message != '')
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  TextApp(_message),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return notifItem(_notif[index]);
              },
              childCount: _notif.length,
            ),
          ),
        ],
      ),
      backgroundColor: ColorApp.light,
    );
  }

  Widget notifItem(Map<String, dynamic> item) => ListTile(
        dense: true,
        title: TextApp(
          item['title'],
          weight: FontWeight.w500,
          color: ColorApp.dark,
        ),
        subtitle: TextApp(
          item['subtitle'],
          color: ColorApp.dark.withOpacity(0.8),
          size: 12,
        ),
        trailing: InkWell(
          child: const Icon(
            Icons.close,
            color: ColorApp.secondary,
            size: 14,
          ),
          onTap: () {
            /** */
          },
        ),
      );
}

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/helpers.dart';
import '../../widgets/button_app.dart';
import '../../widgets/image_app.dart';
import '../routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getImage('inventorywelcome.jpeg')),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black38,
            ),
          ),
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    ImageApp('logo_jatimas.png', width: 150),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ButtonApp(
                        //   text: 'Register',
                        //   margin: const EdgeInsets.all(15),
                        //   width: MediaQuery.of(context).size.width,
                        //   onTap: () async {
                        //     Navigator.pushReplacementNamed(
                        //         context, Routes.privacyPolicy2);
                        //   },
                        // ),
                        ButtonApp(
                          text: 'Sign In',
                          margin: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            Navigator.pushReplacementNamed(
                                context, Routes.login);
                          },
                        ),
                        const SizedBox(height: 20),
                        RichText(
                          text: const TextSpan(
                            text: 'Semangat bekerja Kawan Kawan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                            ),
                            children: [
                              // TextSpan(
                              //   text: 'Sign In',
                              //   style: const TextStyle(
                              //     color: Colors.white,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              //   recognizer: TapGestureRecognizer()
                              //     ..onTap = () =>
                              //         Navigator.pushReplacementNamed(
                              //             context, Routes.login),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: ColorApp.light,
    );
  }
}

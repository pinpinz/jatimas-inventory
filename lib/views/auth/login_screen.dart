import 'package:jatimasinventory/views/home/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive/hive.dart';

import '../../models/auth_model.dart';
import '../../services/api/auth_api.dart';
import '../../utils/colors.dart';
import '../../widgets/background_shape.dart';
import '../../widgets/button_app.dart';
import '../../widgets/image_app.dart';
import '../../widgets/sliver_navbar.dart';
import '../../widgets/snackbar_app.dart';
import '../../widgets/svg_icon.dart';
import '../../widgets/text_app.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _authApi = AuthApi();
  final String _email = '';
  final String _password = '';
  late Box _box;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _box = Hive.box('dataBox');
    });
  }

  @override
  void dispose() {
    /** */

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundShape(),
          CustomScrollView(
            slivers: [
              const SliverNavBar(
                title: 'Sign In',
              ),
              SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.all(15),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const ImageApp('logo_jatimas.png', width: 150),
                        const SizedBox(height: 10),
                        const TextApp('Your Inventory Control System',
                            size: 16),
                        const SizedBox(height: 20),
                        FormBuilder(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'email',
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const SvgIcon(
                                    'Message',
                                    margin: EdgeInsets.fromLTRB(16, 8, 10, 8),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.email(),
                                ]),
                                initialValue: _email,
                              ),
                              const SizedBox(height: 15),
                              FormBuilderTextField(
                                name: 'password',
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const SvgIcon(
                                    'Lock',
                                    margin: EdgeInsets.fromLTRB(16, 8, 10, 8),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                                initialValue: _password,
                                obscureText: _obscureText,
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //     child: const TextApp(
                        //       'Forgot Password?',
                        //       color: ColorApp.primary,
                        //     ),
                        //     onPressed: () {
                        // Navigator.pushNamed(
                        //     context, Routes.forgotPassword);
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 30),
                        ButtonApp(
                          text: 'Continue',
                          width: MediaQuery.of(context).size.width,
                          onTap: () async {
                            if (_formKey.currentState?.saveAndValidate() ??
                                false) {
                              SnackBarApp.loader(context, true);

                              var req = _formKey.currentState!.value;
                              var res = await _authApi.login({
                                'username': req['email'],
                                'password': req['password'],
                              });

                              res.fold(
                                (error) {
                                  SnackBarApp.danger(
                                    context,
                                    error.message.toString(),
                                  );
                                },
                                (response) async {
                                  if (response.code == 200) {
                                    SnackBarApp.loader(context, false);

                                    final auth = AuthModel.fromJson(
                                        response.data.toJson());
                                    await _box.put(
                                        'authToken', auth.token.toString());

                                    if (!mounted) return;

                                    //   Navigator.pushReplacementNamed(
                                    //       context, Routes.dashboard);
                                    // }
                                  } else {
                                    SnackBarApp.danger(
                                      context,
                                      response.message,
                                    );
                                  }
                                },
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                              // SnackBarApp.danger(
                              //   context,
                              //   'Please enter all required fields.',
                              // );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 50,
                    child: Text(
                      'Copyright to CV.Jatimas Inovasi',
                      style: TextStyle(
                        color: ColorApp.secondary,
                        fontWeight: FontWeight.bold,
                      ),
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

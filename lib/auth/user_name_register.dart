import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:movie_demo_selector/models/user.dart';
import 'package:movie_demo_selector/providers/user_provider.dart';
import 'package:movie_demo_selector/services/shared_preferences.dart';
import 'package:provider/provider.dart';

class UserNameRegister extends StatefulWidget {
  const UserNameRegister({super.key});

  @override
  State<UserNameRegister> createState() => _UserNameRegisterState();
}

class _UserNameRegisterState extends State<UserNameRegister> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id;
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor;
      }
    } catch (e) {
      print('Error al obtener el ID del dispositivo: $e');
    }
    return null;
  }

  void saveName(String name) async {
    try {
      setState(() {
        _isLoading = true;
      });
      String? deviceId = await getDeviceId();
      if (deviceId != null) {
        User user = User(
          fechaAlta: DateTime.now(),
          idDispositivo: deviceId,
          nombre: _nameController.text,
        );
        final usuarioService = UserLoginService();
        final usuario = await usuarioService.guardarUsuario(user);
        Provider.of<UserProvider>(context, listen: false).setUserData(user);

        if (!usuario) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error saving user data')),
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/tv.png',
                      width: MediaQuery.of(context).size.width * .45,
                      height: MediaQuery.of(context).size.width * .45,
                      fit: BoxFit.fitWidth,
                    ),
                  ],
                ),
                // Email
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  maxLength: 10,
                  validator: (value) {
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                Text(
                  'Note: Just tell us your name so we can personalize your experience. We don’t store any personal information on external servers — everything stays safely on your device.',
                  style: theme.textTheme.bodySmall,
                ),
                // Botón con loading
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              saveName(_nameController.text);
                            }
                          },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black,
                              ),
                            ),
                          )
                        : const Text('Start'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

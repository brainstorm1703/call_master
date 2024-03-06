import 'package:call_master/theme/theme.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 100, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Як до вас звертатися?',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Будь ласка, укажіть ваше ім\'я для персоналізації сервісу',
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Ваше ім\'я',
                        helperStyle: theme.textTheme.displaySmall,
                        enabledBorder: theme.inputDecorationTheme.enabledBorder,
                        focusedBorder: theme.inputDecorationTheme.enabledBorder,
                      ),
                      style: theme.textTheme.displaySmall,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Введіть ім\'я';
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(251, 12, 186, 112),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed('/home',
                            arguments: {'name': _nameController.text});
                      }
                    },
                    child: Text(
                      'Продовжити',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

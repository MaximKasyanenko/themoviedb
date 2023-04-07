import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/auth/model/auth_model.dart';
import 'my_textfields.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({Key? key}) : super(key: key);
  _resetPassword() {}
  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)!.model;
    final child = model.isRequest
        ? const CircularProgressIndicator()
        : const Text('Войти');
    final tapLoginButton = model.isRequest ? null : () => model.auth(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!model.isValid)
          Text(
            model.errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 21,
            ),
          ),
        Text(
          'UserName',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: model.isValid ? Colors.black : Colors.red,
          ),
        ),
        MyTextFieldWidget(
          controller: model.loginTextController,
        ),
        const SizedBox(height: 25),
        Text(
          'Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: model.isValid ? Colors.black : Colors.red,
          ),
        ),
        MyTextFieldWidget(
          obscureText: true,
          controller: model.passwordTextController,
        ),
        const SizedBox(height: 10),
        Row(children: [
          SizedBox(
            width: 85,
            height: 40,
            child: ElevatedButton(
              onPressed: tapLoginButton,
              child: child,
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: _resetPassword,
            child: const Text(
              'Сбросить пароль',
              style: TextStyle(fontSize: 19, color: Colors.red),
            ),
          )
        ]),
      ],
    );
  }
}

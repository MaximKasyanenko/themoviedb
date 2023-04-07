import 'package:flutter/material.dart';
import 'form_widget.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login to your account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: const [
            SizedBox(height: 30),
            FormWidget(),
            SizedBox(height: 30),
            HeaderWidget(),
          ],
        ),
      ),
    );
  }
}

//MARK: - HeaderWidget -
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        const Text(
          'Войти в свою учётную запись',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '''Чтобы пользоваться правкой и возможностями рейтинга TMDB, а также получить персональные рекомендации, необходимо войти свою учётную запись. Если у вас нет учётной записи, её регистрация является бесплатной и простой.''',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Регистрация',
            style: TextStyle(fontSize: 19, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          '''Если Вы зарегистрировались, но не получили письмо для подтверждения, нажмите здесь, чтобы отправить письмо повторно.''',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
            onPressed: () {},
            child: const Text(
              'Отправить повторно',
              style: TextStyle(fontSize: 19, color: Colors.blue),
            ))
      ],
    );
  }
}

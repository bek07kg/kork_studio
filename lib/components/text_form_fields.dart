import 'package:flutter/material.dart';
import 'package:kork_studio/theme/app_colors.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class TextFormFields extends StatefulWidget {
  const TextFormFields({super.key});

  @override
  _TextFormFieldsState createState() => _TextFormFieldsState();
}

class _TextFormFieldsState extends State<TextFormFields> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendEmail(String name, String email, String message) async {
    setState(() {
      _isLoading = true;
    });

    String username = 'email@gmail.com'; // Ваш email
    String password = 'password'; // Пароль приложения

    final smtpServer = gmail(username, password);

    final mailMessage = Message()
      ..from = Address(username, 'Your App Name')
      ..recipients.add('email@gmail.com')
      ..subject = 'Новое сообщение с сайта: ${DateTime.now()}'
      ..text = 'Имя: $name\nЭлектронный адрес: $email\nСообщение:\n$message';

    try {
      final sendReport = await send(mailMessage, smtpServer);
      print('Сообщение отправлено: $sendReport');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Сообщение успешно отправлено!')),
      );
    } on MailerException catch (e) {
      print('Ошибка при отправке сообщения: $e');
      for (var p in e.problems) {
        print('Проблема: ${p.code}: ${p.msg}');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при отправке сообщения: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String message = _messageController.text;

      await _sendEmail(name, email, message);

      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextFormField("Имя*", _nameController, "Ваше имя..."),
            const SizedBox(height: 30),
            _buildTextFormField(
                "Электронный адрес*", _emailController, "Электронный адрес...",
                isEmail: true),
            const SizedBox(height: 30),
            _buildTextFormField(
                "Сообщение*", _messageController, "Ваше сообщение...",
                maxLines: 6),
            const SizedBox(height: 50),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 60,
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.grey,
                      ),
                      onPressed: _submitForm,
                      child: Center(
                        child: Text(
                          "Отправить",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontFamily: "LTWave",
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

  // Вынесение общего виджета для TextFormField
  Widget _buildTextFormField(
      String label, TextEditingController controller, String hintText,
      {bool isEmail = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "LTWave",
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: "LTWave",
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xff373737),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xff373737), width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Это поле необходимо заполнить';
            } else if (isEmail &&
                !RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+')
                    .hasMatch(value)) {
              return 'Введите корректный адрес электронной почты';
            }
            return null;
          },
        ),
      ],
    );
  }
}

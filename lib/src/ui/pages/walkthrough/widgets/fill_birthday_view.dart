import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FillBirthdayView extends StatelessWidget {
  const FillBirthdayView({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Text(
            '輸入您的生日',
            style: TextStyle(color: Colors.white, fontSize: 32),
          ),
          const SizedBox(height: 20),
          const Text(
            '我們將為您推薦更相關的聊天室，讓您找到志同道合的朋友一起大吐苦水！',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: '年/月/日',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  filled: false,
                  suffixIcon: const FaIcon(FontAwesomeIcons.calendar),
                  suffixIconConstraints: const BoxConstraints(minWidth: 36),
                  suffixIconColor: Colors.white),
              style: const TextStyle(color: Colors.white),
              readOnly: true,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                ).then((DateTime? value) {
                  if (value != null) {
                    controller.text =
                        '${value.year}/${value.month}/${value.day}';
                  }
                });
              })
        ],
      ),
    );
  }
}

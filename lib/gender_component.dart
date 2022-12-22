
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'Res/constants/providers/provider_notifiers.dart';

class UserGenderComponent extends StatelessWidget {
  UserGenderComponent({super.key});
  final genderList = ["Male", "Female", "Others"];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Please Select Gender",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
        ValueListenableBuilder(
          valueListenable: imageOptions,
          builder: (context, value, child) {
            return RadioGroup<String>.builder(
              groupValue: value ?? "",
              onChanged: (value) {
                imageOptions.value = value;
              },
              items: genderList,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            );
          },
        ),
      ],
    );
  }
}
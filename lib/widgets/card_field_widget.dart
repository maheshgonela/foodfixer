import 'package:flutter/material.dart';
import 'package:foodfixer/styles/text_styles.dart';

class CardFieldWidget extends StatelessWidget {
  const CardFieldWidget(this.title, this.text, {super.key});

  final String title;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('$title : ', style: TextStyles.k12Bold(context)),
          Expanded(child: Text((text ?? '').trim(), style: TextStyles.k10(context))),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  IconData? icon;
  VoidCallback onClick;
  String text;
  CommonButton({Key? key, required this.text, required this.onClick,  this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onClick, child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon == null ? Container() : Icon(icon)
      ],
    ));
  }
}

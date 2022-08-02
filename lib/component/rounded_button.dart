import 'package:flutter/material.dart';
class buttons extends StatelessWidget {
  late Color color;
  final Function() onPressed;
  late String name;
  buttons({required this.color,required this.name,required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            '$name',
            style:TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

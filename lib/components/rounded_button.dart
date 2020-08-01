import 'package:good_sprout/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = darkGreenColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      height: size.height * 0.06,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          color: color,
          onPressed: press,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: darkGreenColor, width: 2.5),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}

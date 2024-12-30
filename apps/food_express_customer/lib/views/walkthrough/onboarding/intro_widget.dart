import 'package:flutter/material.dart';
import 'package:shared/colors.dart';

class IntroWidget extends StatelessWidget {
  final image;
  final type;

  final String subText;

  const IntroWidget({super.key, this.image, this.type, required this.subText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Center(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 0.5),
            child: Center(
              child: Text(
                type.toString(),
                style: TextStyle(
                    color: black_text_color,
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Center(
                child: Text(
                  subText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: grey_sub_text_color,
                      height: 1.5,
                      letterSpacing: 1.0,
                      wordSpacing: 3.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

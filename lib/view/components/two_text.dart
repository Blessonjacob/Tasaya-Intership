import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TwoText extends StatelessWidget {
  String firstText;
  String secondText;
  MainAxisAlignment mainAxisAlignment;
  TwoText({Key? key, required this.firstText, required this.secondText, this.mainAxisAlignment = MainAxisAlignment.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          '$firstText ',
          style: GoogleFonts.elMessiri(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        Flexible(
          child: Text(
            secondText,
            style: GoogleFonts.elMessiri(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

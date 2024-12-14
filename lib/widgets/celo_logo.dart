import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CeloLogo extends StatelessWidget {
  const CeloLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/celo-long-form-logo.svg",
      semanticsLabel: 'Celo Logo',
      width: 100,
    );
  }
}

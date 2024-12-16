import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/appkit_modal.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ReownAppKitModal appKit;

  const CustomAppBar({super.key, required this.appKit});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      title: SvgPicture.asset(
        "assets/celo-long-form-logo.svg",
        semanticsLabel: 'Celo Logo',
        width: 100,
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppKitModalConnectButton(
            size: BaseButtonSize.small,
            appKit: appKit,
            context: context,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

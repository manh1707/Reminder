import 'package:flutter/material.dart';
import 'package:reminder/const/assets.dart';
import 'package:reminder/const/color.dart';
import 'package:reminder/const/font.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar(
      {super.key, required this.title, this.leading, this.actions});
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bg1Color,
      leading: isShowBackButton(context) ? const BackButton() : leading,
      centerTitle: true,
      title: Text(
        title,
        style: heading3.copyWith(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  bool isShowBackButton(BuildContext context) {
    return Navigator.of(context).canPop() && leading == null;
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Image.asset(MyIconAssets.arrowLeft),
    );
  }
}

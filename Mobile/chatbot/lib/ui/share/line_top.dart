import 'package:flutter/material.dart';

class LineTop extends StatelessWidget implements PreferredSizeWidget {
  const LineTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      color: Color.fromARGB(255, 208, 208, 208),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(1.0);
}

import 'package:flutter/material.dart';
import 'package:nitro_corn/const.dart';

class LoginScaffoldWidget extends StatelessWidget {
  final Widget widget;
  const LoginScaffoldWidget({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: getAppTitleText(),
            automaticallyImplyLeading: false,
            centerTitle: true,
            flexibleSpace: Container(
              decoration: getGradientColorDecoration(),
            ),
          ),
          body: widget),
    );
  }
}

import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  String? title;
  bool? isLoginButton;
  VoidCallback? onPress;
  bool? isLoading;

  EcoButton(
      {super.key,
      this.title,
      this.isLoginButton = false,
      this.onPress,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: isLoginButton == false ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isLoginButton == false ? Colors.black : Colors.black,
            )),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading! ? false : true,
              child: Center(
                child: Text(
                  title ?? "Button",
                  style: TextStyle(
                    color: isLoginButton == false ? Colors.black : Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isLoading!,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

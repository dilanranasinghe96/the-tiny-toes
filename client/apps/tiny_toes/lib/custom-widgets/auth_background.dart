import 'package:flutter/material.dart';
import 'package:tiny_toes/custom-widgets/custom_text.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({
    super.key,
    required this.size,
    required this.content,
  });

  final Size size;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.6,
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
            child: Align(
              alignment: Alignment.center,
              child: CustomText(
                  text: 'Ther Tiny Toes',
                  color: Colors.white,
                  fsize: 30 ,
                  fweight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: size.height * 0.5,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LikedButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isLiked;
  LikedButton({super.key, this.onTap, required this.isLiked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.grey,
      ),
    );
  }
}

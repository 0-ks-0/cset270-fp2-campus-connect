import "package:flutter/material.dart";

class PrimaryButton extends StatelessWidget
{
  final Function()? onTap;
  final String text;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14 * 3),

        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,

          borderRadius: BorderRadius.circular(100),
        ),

        child: Center(
          child: Text(
            text,

            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String lable;
  final IconData icon;
  final GestureTapCallback? onTap;
  const UserCard({
    Key? key,
    required this.lable,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              lable,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

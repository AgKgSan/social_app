import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const MyDrawerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),textColor: Theme.of(context).colorScheme.inversePrimary,
      leading: Icon(icon),iconColor: Theme.of(context).colorScheme.primary,
      onTap: onTap,
    );
  }
}

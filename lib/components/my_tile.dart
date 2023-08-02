import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onPressIconButton;
  final String userAvatar;
  final String userFullName;
  final String userEmail;
  final bool isVisible;
  const MyUserTile({
    super.key,
    required this.onTap,
    required this.onPressIconButton,
    required this.userAvatar,
    required this.userFullName,
    required this.userEmail,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(userAvatar),
        radius: 20,
      ),
      title: Text(userFullName),
      subtitle: Text(userEmail),
      trailing: isVisible
          ? IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: onPressIconButton,
            )
          : null,
    );
  }
}

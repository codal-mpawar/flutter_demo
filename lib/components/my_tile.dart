import 'package:demo/components/my_label.dart';
import 'package:flutter/material.dart';

class MyUserTile extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onPressIconButton;
  final user;
  final bool isVisible;
  const MyUserTile({
    super.key,
    required this.onTap,
    required this.onPressIconButton,
    required this.user,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    var userFullName = user['first_name'] + ' ' + user['last_name'];
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user['avatar']),
        radius: 40,
      ),
      title: MyTextLabel(
        text: userFullName,
        size: 20,
      ),
      subtitle: MyTextLabel(
        text: user['email'],
        size: 18,
      ),
      trailing: isVisible
          ? IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: onPressIconButton,
            )
          : null,
    );
  }
}

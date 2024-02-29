import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetErrorDialog extends StatelessWidget {
  final VoidCallback onRefresh;

  const InternetErrorDialog({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Error',
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Text(
        'Please check your internet connection or',
        style: Theme.of(context).textTheme.bodyMedium,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          onPressed: onRefresh,
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          icon: const Icon(
            CupertinoIcons.refresh_circled,
            color: Colors.white,
          ),
          label: Text(
            'Refresh',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

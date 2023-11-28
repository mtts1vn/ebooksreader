import 'package:flutter/material.dart';

class ErrorPopup extends StatelessWidget {
  final String errorMessage;
  final Function onRetry;

  const ErrorPopup({
    Key? key,
    required this.errorMessage,
    required this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Algo deu errado :(',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(errorMessage),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              onRetry();
            },
            child: const Text('Tentar Novamente'),
          ),
        ],
      ),
    );
  }
}

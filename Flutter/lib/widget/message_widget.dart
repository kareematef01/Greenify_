import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final bool isFromUser;

  const MessageWidget({
    super.key,
    required this.message,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment:
            isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isFromUser) ...[
            // صورة النظام (chatbot)
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/pot.jpg'), // حطي هنا مسار الصورة
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: isFromUser
                    ? Colors.green[600]
                    : Colors.green[100],
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: Radius.circular(isFromUser ? 16.0 : 0),
                  bottomRight: Radius.circular(isFromUser ? 0 : 16.0),
                ),
              ),
              child: MarkdownBody(
                data: message,
                styleSheet:
                    MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                  p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isFromUser
                            ? Colors.white
                            : Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                      ),
                ),
              ),
            ),
          ),
          if (isFromUser) ...[
            const SizedBox(width: 8),
            // صورة المستخدم (اختياري)
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.green[600],
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}

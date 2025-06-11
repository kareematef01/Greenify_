import 'package:flutter/material.dart';
import 'package:please_work/widget/message_widget.dart';
import 'package:please_work/util/app_const.dart';
import 'package:please_work/widget/chat_text_from_feild.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AskExpertScreen extends StatefulWidget {
  const AskExpertScreen({super.key});

  @override
  State<AskExpertScreen> createState() => _AskExpertScreenState();
}

class _AskExpertScreenState extends State<AskExpertScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final GenerativeModel _model;
  late ChatSession _chatSession;
  late final ScrollController _scrollController;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: geminiModel,
      apiKey: "AIzaSyBh6XmALRTn74SFYVNd8b6EF9s9nUyO1fE",
    );
    _scrollController = ScrollController();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _isLoading = false;

    // Start the chat
    _chatSession = _model.startChat();
  }

  void _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ask chatbot"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _chatSession.history.length,
          itemBuilder: (context, index) {
            var content = _chatSession.history.elementAt(index);
            final message = _getMessageFromContent(content);
            return MessageWidget(
              isFromUser: content.role == 'user',
              message: message,
            );
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Form(
                  key: _formKey,
                  child: ChatTextFromFeild(
                    controller: _textController,
                    focusNode: _focusNode,
                    isReadOnly: _isLoading,
                    onFieldSubmitted: _sendChatMessage,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              if (!_isLoading)
                ElevatedButton(
                  onPressed: () {
                    _sendChatMessage(_textController.text);
                  },
                  child: const Text('Send'),
                )
              else
                const CircularProgressIndicator.adaptive(),
            ],
          ),
        ),
      ),
    );
  }

  String _getMessageFromContent(Content content) {
    return content.parts.whereType<TextPart>().map((e) => e.text).join("");
  }

  void _sendChatMessage(String message) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _setLoading(true);
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      final text = response.text;
      if (text == null) {
        _showError("No Response Was Found");
      }
    } catch (e) {
      _showError(e.toString());
    } finally {
      _textController.clear();
      _focusNode.requestFocus();
      _setLoading(false);
    }
  }

  void _showError(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            scrollable: true,
            content: SingleChildScrollView(
              child: Text(message),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}

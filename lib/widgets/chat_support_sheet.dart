import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app_config/constants.dart';

class ChatSupportSheet extends StatefulWidget {
  const ChatSupportSheet({super.key});
  @override
  State<ChatSupportSheet> createState() => _ChatSupportSheetState();
}

class _ChatSupportSheetState extends State<ChatSupportSheet> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"role": "assistant", "content": "Hello! I am your FixIt AI assistant. How can I help you today?"}
  ];
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;
    final userText = _controller.text;

    setState(() {
      _messages.add({"role": "user", "content": userText});
      _isLoading = true;
      _controller.clear();
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": _messages,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiText = data['choices'][0]['message']['content'];
        setState(() => _messages.add({"role": "assistant", "content": aiText}));
      } else {
        setState(() => _messages.add({"role": "assistant", "content": "Error: Check API Key."}));
      }
    } catch (e) {
      setState(() => _messages.add({"role": "assistant", "content": "Connection Error."}));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            child: Row(children: const [
              Icon(Icons.support_agent, color: Colors.white),
              SizedBox(width: 10),
              Text("Quick Support", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.green[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['content']!, style: const TextStyle(color: Colors.black87)),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) const Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 16, right: 16, top: 10),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller, decoration: InputDecoration(hintText: "Ask a question...", border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)), filled: true, fillColor: Theme.of(context).cardColor))),
                const SizedBox(width: 10),
                FloatingActionButton.small(onPressed: _sendMessage, backgroundColor: Colors.green, child: const Icon(Icons.send, color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

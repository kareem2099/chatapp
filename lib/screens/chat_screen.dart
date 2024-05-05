import 'package:chatapp/services/chat_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:intl/intl.dart';
import 'package:chatapp/widgets/record_voice_widget.dart';

class ChatScreen extends StatefulWidget {
  final Chats chat;
  final Function(String) onNewMessageSend; // Corrected parameter name

  const ChatScreen(
      {Key? key, required this.chat, required this.onNewMessageSend})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Define the TextEditingController
  final TextEditingController _controller = TextEditingController();
  String lastMessage = '';
  List<Message> messages = [];
  final VoiceRecorder _voiceRecorder = VoiceRecorder();

  void sendMessage(String text) {
    final newMessage = Message(
      content: text,
      sender: 'Me',
      timestamp: DateTime.now(),
    );

    setState(() {
      messages
          .add(newMessage); // Add the new message to the local messages list
      widget.chat.message
          .add(newMessage); // Add the new message to the chat's message list
      widget.chat.lastMessage = text; // Update the lastMessage field
      widget.onNewMessageSend(text);
    });

    _controller.clear();
  }

  void _onVoiceMessageStart() async {
    try {
      await _voiceRecorder.startRecording();
      // Show some indication to the user that recording started
    } catch (e) {
      // Handle error
    }
  }

  void _onVoiceMessageEnd() async {
    try {
      await _voiceRecorder.stopRecording();
      // Handle the recorded voice message
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchDelegate =
        ChatSearchDelegate(ChatList, onNewMessageSend: (message) {});
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.chat.img),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chat.name),
                Text(
                  widget.chat.isOnline
                      ? 'Online'
                      : 'Last seen ${widget.chat.lastSeen}',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final currentTime = DateTime.now();
                final messageTime = DateFormat.Hm().format(currentTime);
                return ListTile(
                  title: Text(message.content),
                  subtitle: Text(
                    '${message.sender} • ${DateFormat.Hm().format(message.timestamp)}',
                  ),
                  // Align the message based on the sender
                  trailing: message.sender == 'Me' ? null : Icon(Icons.person),
                  leading: message.sender == 'Me' ? Icon(Icons.person) : null,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                GestureDetector(
                  onLongPress: _onVoiceMessageStart,
                  onLongPressEnd: (details) => _onVoiceMessageEnd(),
                  child: Icon(Icons.mic),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);

                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }
}

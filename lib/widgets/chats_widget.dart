import 'package:flutter/material.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/model/chat_model.dart';

class ChatsList extends StatefulWidget {
  final List<Chats> filteredChatList;

  const ChatsList({Key? key, required this.filteredChatList}) : super(key: key);

  @override
  _ChatsListState createState() => _ChatsListState();
}

class _ChatsListState extends State<ChatsList> {
  String _searchQuery = '';
  @override
  void handleNewMessage(String newMessage) {
    setState(() {
      for (var chat in widget.filteredChatList) {
        if (chat.lastMessage.isNotEmpty) {
          chat.lastMessage = newMessage;
          break;
        }
      }
    });
  }

  void initState() {
    super.initState();
    calculateLastMessage();
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredChatList = _searchQuery.isEmpty
        ? widget.filteredChatList
        : widget.filteredChatList
            .where((chat) =>
                chat.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: _updateSearchQuery,
            decoration: InputDecoration(
              hintText: 'search...',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: filteredChatList.length,
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(filteredChatList[index].img),
                ),
                title: Text(filteredChatList[index].name),
                subtitle: Row(
                  children: [
                    Expanded(
                      child: Text(filteredChatList[index].lastMessage),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(filteredChatList[index].clock)
                  ],
                ),
                trailing: filteredChatList[index].icon,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ChatScreen(
                        chat: filteredChatList[index],
                        onNewMessageSend: handleNewMessage,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

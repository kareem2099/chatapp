import 'package:chatapp/screens/camera_screeen.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/chat_search_delegate.dart';
import 'package:chatapp/model/chat_model.dart';
import 'package:chatapp/widgets/chats_widget.dart';
import 'package:chatapp/widgets/stories_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredChatList = _searchQuery.isEmpty
        ? ChatList
        : ChatList.where((chat) =>
                chat.name.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Chats",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    final searchDelegate = ChatSearchDelegate(ChatList,
                        onNewMessageSend: (message) {
                      // Handle new message send action here
                    });

// Trigger search
                    showSearch(context: context, delegate: searchDelegate);
                  },
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CameraScreen()),
                    );
                  },
                  icon: const Icon(Icons.camera_alt_rounded),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Add your edit action here
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: StoriesList(),
            ),
            Expanded(
              child: filteredChatList.isNotEmpty
                  ? ChatsList(filteredChatList: filteredChatList)
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

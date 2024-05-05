import 'package:flutter/material.dart';
import 'package:chatapp/model/chat_model.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({Key? key}) : super(key: key);

  @override
  _StoriesListState createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList>
    with TickerProviderStateMixin {
  late List<bool> _viewedStories;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _viewedStories = List.generate(ChatList.length, (index) => false);
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ChatList.length,
        itemBuilder: (context, index) {
          final chat = ChatList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                _viewedStories[index] = true;
              });
              _showStoryPopup(context, chat.name);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[300],
                    child: ScaleTransition(
                      scale: _viewedStories[index] ? _animation : _controller,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(chat.img),
                      ),
                    ),
                  ),
                  if (_viewedStories[index])
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showStoryPopup(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Message"),
          content: Text("You are viewing $name's story."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

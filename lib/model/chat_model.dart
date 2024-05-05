import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chats {
  final String img;
  final String name;

  final String msg;
  final String clock;
  final String lastSeen;
  final Widget icon;
  final bool isOnline;
  final List<Message> message;
  String lastMessage;

  Chats({
    required this.img,
    required this.name,
    required this.msg,
    required this.clock,
    required this.icon,
    required this.isOnline,
    required this.lastSeen,
    required this.message,
    required this.lastMessage,
  });
}

class Message {
  final String content;
  final String sender;
  final DateTime timestamp;

  Message({
    required this.content,
    required this.sender,
    required this.timestamp,
  });
}

List<Chats> ChatList = [
  Chats(
    img: "assets/images/first.jpg",
    name: "Sofia",
    msg: "How are you ?",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "Sofia", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/sec.jpg",
    name: "Scarlett",
    msg: "Are you good?",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "Scarlett", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/third.jpg",
    name: "namy",
    msg: "luffy tasukete",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "namy", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/fourth.jpg",
    name: "karizma",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "karizma", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/fifth.jpg",
    name: "alan",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "alan", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/sixth.jpg",
    name: "dan",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "dan", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/seventh.jpg",
    name: "malika",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "malika", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/eighth.jpg",
    name: "john",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "john", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/ninth.jpg",
    name: "Zahir",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(content: "hello!", sender: "Zahir", timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
  Chats(
    img: "assets/images/tenth.jpg",
    name: "Samuel L.jackson",
    msg: "how are you",
    clock: "01:25",
    icon: Icon(Icons.check_circle),
    isOnline: true,
    lastSeen: "yesterday",
    message: [
      Message(
          content: "hello!",
          sender: "Samuel L.jackson",
          timestamp: DateTime.now()),
    ],
    lastMessage: "",
  ),
];

void calculateLastMessage() {
  for (var chat in ChatList) {
    if (chat.message.isNotEmpty) {
      chat.lastMessage = chat.message.last.content;
    } else {
      chat.lastMessage = '';
    }
  }
}

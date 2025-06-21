import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chats = [
    {"name": "Geoport Edsien", "message": "Your Order Just Arrived!", "time": "11:23"},
    {"name": "Stevano Clirover", "message": "Just to order", "time": "13:47"},
    {"name": "Elisia Justin", "message": "Your Order Just Arrived!", "time": "13:47"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat List"), centerTitle: true),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(chat['name']!),
            subtitle: Text(chat['message']!),
            trailing: Text(chat['time']!),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(name: chat['name']!)),
            ),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String name;

  ChatScreen({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [IconButton(icon: Icon(Icons.call), onPressed: () {
          Get.to(()=>CallScreen(user: 'Geoport Edsion'));
        })],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: [
                Align(alignment: Alignment.centerLeft, child: ChatBubble(text: "Just to order", isSent: false)),
                Align(alignment: Alignment.centerRight, child: ChatBubble(text: "Okay, for what level of spiciness?", isSent: true)),
                Align(alignment: Alignment.centerLeft, child: ChatBubble(text: "Okay. Wait a minute. 🔥", isSent: false)),
                Align(alignment: Alignment.centerRight, child: ChatBubble(text: "Okay, I'm waiting 😎", isSent: true)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type something...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.send, color: Colors.green), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSent;

  ChatBubble({required this.text, required this.isSent});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSent ? Colors.green[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(text),
    );
  }
}
class CallScreen extends StatelessWidget {
  final String user;

  CallScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
      ),
      backgroundColor: Colors.green.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            backgroundImage: AssetImage('assets/user.png'),
          ),
          SizedBox(height: 10),
          Text(
            user,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            width: 70,
            color: Colors.white.withOpacity(0.4),
            child: Text(
              '03:45',
              style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 30,
                child: IconButton(
                  icon: Icon(Icons.mic, color: Colors.black),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 30,
                child: IconButton(
                  icon: Icon(Icons.call_end, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 20),
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                radius: 30,
                child: IconButton(
                  icon: Icon(Icons.volume_up, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
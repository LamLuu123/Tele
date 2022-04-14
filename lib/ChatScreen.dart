import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final _messageFocusNode = FocusNode();

  bool _isComposing = false;
  Widget _buildComposer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        children: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.sentiment_very_satisfied_outlined)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                decoration: InputDecoration.collapsed(
                  hintText: 'Your message here...',
                ),
                onChanged: (value) {
                  setState(() {
                    _isComposing = value.isNotEmpty;
                  });
                },
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.attachment_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mic_none),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
              title: Text("Con cu"),
              actions: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/back.png"), fit: BoxFit.cover),
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text(
                              'No message here',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        final docs = snapshot.data.documents;
                        return ListView(
                          padding: EdgeInsets.all(8.0),
                          reverse: true,
                          children: List.generate(
                            docs.length,
                                (index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Anonymous'),
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8.0),
                                        topRight: Radius.circular(8.0),
                                        bottomLeft: Radius.circular(8.0),
                                        bottomRight: Radius.circular(8.0),
                                      ),
                                    ),
                                    color: Colors.blueGrey,
                                    elevation: 0.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        docs[index]['message'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  _buildComposer(),
                ],
              ),
            )));
  }
}

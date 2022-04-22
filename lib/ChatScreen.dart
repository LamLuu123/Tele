import 'package:flutter/material.dart';
import 'Database.dart';
import 'Home.dart';
import 'data.dart';
import 'message.dart';
import 'user.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  final User user;
  const ChatScreen({@required this.user,Key key}):super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  bool _messageEmpty=true;
  String Messages='';
  void sendMess()async{
    FocusScope.of(context).unfocus();
    await FirebaseApi.uploadMessage(widget.user.idUser,myId,Messages);
    _messageController.clear();
    setState(() {
      _messageEmpty=true;
    });
  }
  Widget _buildComposer() => Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Row(
        children: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.sentiment_very_satisfied_outlined)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _messageController,
                focusNode: _messageFocusNode,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Your message here...',
                ),
                onChanged: (value) {
                  setState(() {
                    Messages=value;
                    if(_messageController.text!=''){
                      _messageEmpty=false;
                    }else {
                      _messageEmpty=true;
                    }
                  });
                },
              ),
            ),
          ),

          if(_messageEmpty)IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.attachment_rounded),
          ),
          if (_messageEmpty) IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic_none),
          ) else IconButton(onPressed: Messages.trim().isEmpty?null: sendMess, icon: Icon(Icons.send))
        ],
      ),
    );

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData.dark(),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext contxet) => Home()));}, icon: Icon(Icons.arrow_back)),
              title: Text(widget.user.name),
              actions: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.call)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined)),
              ],
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/back.png"), fit: BoxFit.cover),
              ),
              child: SafeArea(
                child:Column(children: <Widget>[
                  Expanded(
                  child: StreamBuilder<List<Message>>(
                      stream: FirebaseApi.getMessages(widget.user.idUser,myId),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                        //case ConnectionState.waiting:
                        //return Center(child: CircularProgressIndicator());
                          default:
                            if (snapshot.hasError) {
                              return buildText(
                                  'Something Went Wrong Try later');
                            } else {
                              final messages = snapshot.data;
                              if (messages?.isEmpty??true) {
                                return const Center(
                                child: Text(
                                  'Say Hi...',
                                  style: TextStyle(fontSize: 24, color: Colors.black),
                                ),
                              );
                              } else {
                                return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  bool isMe=false;
                                  if(messages[index].idUser == myId){
                                    isMe=true;
                                  }
                                  else {
                                    isMe=false;
                                  }
                                  final message = messages[index];
                                  final radius = Radius.circular(20);
                                  final borderRadius = BorderRadius.all(radius);
                                  return Row(
                                    mainAxisAlignment: isMe
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,
                                    children: <Widget>[
                                      if (!isMe)
                                        CircleAvatar(
                                            radius: 10,
                                            backgroundImage: NetworkImage(
                                                message.urlAvatar)),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        margin: const EdgeInsets.all(2),
                                        constraints: const BoxConstraints(
                                            maxWidth: 140),
                                        decoration: BoxDecoration(
                                          color: isMe
                                              ? Colors.pink[100]
                                              : Theme
                                              .of(context)
                                              .accentColor,
                                          borderRadius: isMe
                                              ? borderRadius.subtract(
                                              BorderRadius.only(
                                                  bottomRight: radius))
                                              : borderRadius.subtract(
                                              BorderRadius.only(
                                                  bottomLeft: radius)),
                                        ),
                                        child: buildMessage(message),
                                      ),
                                    ],
                                  );
                                },);
                              }
                            }
                        }
                      }),
                ),
                  _buildComposer(),],)


          )
              ),
            ));
}
Widget buildText(String text) => Center(
  child: Text(
    text,
    style: const TextStyle(fontSize: 24, color: Colors.white),
  ),
);
Widget buildMessage(Message message){
  bool isMe;
  if(message.idUser==myId){
    isMe=true;
  }
  else {
    isMe=false;
  }
  return Column(
  crossAxisAlignment:
  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
  children: <Widget>[
    Text(
      message.message,
      style: TextStyle(color: isMe ? Colors.black : Colors.white),
      textAlign: isMe ? TextAlign.end : TextAlign.start,
    ),
  ],
);
}
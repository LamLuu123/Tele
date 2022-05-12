import 'package:flutter/material.dart';
import 'Database.dart';
import 'Home.dart';
import 'data.dart';
import 'message.dart';

class SavedScreen extends StatefulWidget {
  static const id = 'chat_screen';
  final String user;
  const SavedScreen({@required this.user,Key key}):super(key: key);
  @override
  _SavedScreen createState() => _SavedScreen();
}

class _SavedScreen extends State<SavedScreen> {
  bool isLoading = false;
  ScrollController _chatScrollController;
  int loadMoreMsgs = 20; // at first it will load only 20
  int a = 50;
  final TextEditingController _messageController = TextEditingController();
  final _messageFocusNode = FocusNode();
  bool _messageEmpty=true;
  String Messages='';
  void initState() {
    _chatScrollController = ScrollController()
      ..addListener(() async {
        if (_chatScrollController.position.atEdge) {
          if (_chatScrollController.position.pixels == 0){
            setState(() {
              isLoading = false;
            });
            //print('ListView scrolled to top');
          }
          else {

            if (!isLoading) {
              setState(() {
                isLoading = true;
              });
            }
            await FirebaseApi.getSaveMessagesLeng(account.idUser).
            forEach((element) {
              setState(() {
                if(loadMoreMsgs<element.length) {
                  loadMoreMsgs =  loadMoreMsgs + a;
                  //print('ListView scrolled to bottom '+loadMoreMsgs.toString()+ isLoading.toString());
                }else{
                  isLoading = false;
                  //print('ListView scrolled to bottom '+loadMoreMsgs.toString()+ isLoading.toString());
                }
              });
            });
            // }
            //print('ListView scrolled to bottom '+loadMoreMsgs.toString()+ isLoading.toString());
          }
        }
      });
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _chatScrollController.dispose();
    _messageController.dispose();
    _messageFocusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void sendMess()async{
    FocusScope.of(context).unfocus();
    _messageController.clear();
    setState(() {
      _messageEmpty=true;
    });
    await FirebaseApi.uploadSaveMessage(account.idUser,Messages);
  }
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity:1.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
  Widget _buildComposer() => Container(
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
              textCapitalization: TextCapitalization.sentences,
              controller: _messageController,
              focusNode: _messageFocusNode,
              decoration: InputDecoration.collapsed(
                hintText: 'Your message here...',
              ),
              onChanged: (value) {
                setState(() {
                  Messages=value;
                  if(_messageController.text!=''){
                    _messageEmpty=false;
                  }else _messageEmpty=true;
                });
              },
            ),
          ),
        ),

        if(_messageEmpty)IconButton(
          onPressed: () {
          },
          icon: Icon(Icons.attachment_rounded),
        ),
        _messageEmpty?IconButton(
          onPressed: () {},
          icon: Icon(Icons.mic_none),
        ):IconButton(onPressed: Messages.trim().isEmpty?null: sendMess, icon: Icon(Icons.send))
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (BuildContext contxet) => Home()));}, icon: Icon(Icons.arrow_back)),
          title: Row( children: <Widget>[
            Flexible(
              child:
              CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 20,
              ),
            ),
            Flexible(child: Text(" Save Messages",softWrap: false,overflow: TextOverflow.clip,)),],
            //subtitle: Text('online',style: TextStyle(fontSize: 8)),
          ),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(
              icon: Icon(Icons.more_vert_outlined),
              itemBuilder: (context)=>[
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.search),
                    title: Text('Search'),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.color_lens_sharp),
                    title: Text('Change color'),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.brush),
                    title: Text('Clear history'),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.delete_outline),
                    title: Text('Delete chat'),
                  ),
                ),
              ],
              color: Colors.blueGrey,
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/back.png"), fit: BoxFit.cover),
            ),
            child: SafeArea(
                child:Column(children: <Widget>[
                  Expanded(
                    child: StreamBuilder<List<Message>>(
                        stream: FirebaseApi.getSaveMessages(account.idUser,loadMoreMsgs),
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
                                      "Say Hi...",
                                      style: TextStyle(fontSize: 24, color: Colors.black),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                    controller: _chatScrollController,
                                    physics: BouncingScrollPhysics(),
                                    reverse: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      bool isMe=false;
                                      if(messages[index].idUser == account.idUser){
                                        isMe=true;
                                      }
                                      else isMe=false;
                                      final message = messages[index];
                                      final radius = Radius.circular(20);
                                      final borderRadius = BorderRadius.all(radius);
                                      return (index==messages.length-1&&isLoading)? _buildProgressIndicator() :Row(
                                        mainAxisAlignment: (isMe)
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: <Widget>[
                                          if (!isMe)
                                            CircleAvatar(
                                                radius: 10,
                                                backgroundImage: NetworkImage(
                                                    message.urlAvatar)),
                                          Container(
                                            padding: EdgeInsets.all(16),
                                            margin: EdgeInsets.all(2),
                                            constraints: BoxConstraints(
                                                maxWidth: 140),
                                            decoration: BoxDecoration(
                                              color: (isMe)
                                                  ? Colors.pink[100]
                                                  : Theme
                                                  .of(context)
                                                  .accentColor,
                                              borderRadius: (isMe)
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
    style: TextStyle(fontSize: 24, color: Colors.white),
  ),
);
Widget buildMessage(Message message){
  bool isMe;
  if(message.idUser==account.idUser){
    isMe=true;
  }
  else isMe=false;
  return Column(
    crossAxisAlignment:
    (isMe) ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        message.message,
        style: TextStyle(color: (isMe) ? Colors.black : Colors.white),
        textAlign:TextAlign.start,
      ),
    ],
  );
}
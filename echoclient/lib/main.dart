import 'package:flutter/material.dart';
import 'package:echoclient/echoservice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _reply="";
  var service=EchoService();
  var currentReply="";
  final request_text_controller = TextEditingController();
  void _sendToServer() async{
    var reply=await service.commitMessage(request_text_controller.text);
    setState(() {
       _reply=reply.replyContent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Write Request Message bellow and tap send button',
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                  controller: request_text_controller,
                  decoration: InputDecoration(border: OutlineInputBorder())),
            ),
            Text(
              '$_reply',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendToServer,
        tooltip: 'Action',
        child: Icon(Icons.send),
      ), 
    );
  }
}

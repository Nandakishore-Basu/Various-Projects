import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController tec = TextEditingController();
  String url = 'https://text.pollinations.ai/prompt/';
  String newurl = '';
  String prompt = '';
  String response = 'Hi ! Start Chatting';
  genText(String url) async {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Fetching Data'),
    //     duration: Duration(milliseconds: 1200),
    //   ),
    // );
    setState(() {
      response = 'Loading Data... Please Wait...';
    });
    var res = (await http.get(Uri.parse(url))).body;
    setState(() {
      response = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat AI', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            showInfo(context);
          },
          icon: Icon(Icons.info_outline, color: Colors.redAccent),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (prompt) async {
                        String x = prompt != '' ? prompt : 'hi';
                        newurl = url + x;
                        await genText(newurl);
                      },
                      controller: tec,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () async {
                      prompt = tec.text != '' ? tec.text : 'hi';
                      newurl = url + prompt;
                      await genText(newurl);
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SelectableText(
                        response,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: response));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied To Clipboard!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(Icons.copy),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showInfo(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 10),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'App Developed by Nandakishore Basu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            'Email: nandakishore.basu@gmail.com',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(
            'Image Credits : pollinations.ai',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

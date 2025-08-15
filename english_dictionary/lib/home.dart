import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String word = '';
  var meaning;
  TextEditingController tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        elevation: 5,
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Text('Dictionary'),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: tec,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search The Word',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: (value) {
                    word = value;
                    setState(() {
                      meaning = getData(word);
                    });
                  },
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  word = tec.text;
                  setState(() {
                    meaning = getData(word);
                  });
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: meaning,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          }

          var data = snapshot.data as List<dynamic>;
          String word = data[0]['word'].toUpperCase();
          String phonetic = '';
          if (data[0]['phonetic'] != null &&
              data[0]['phonetic'].toString().isNotEmpty) {
            phonetic = data[0]['phonetic'];
          } else if (data[0]['phonetics'] != null &&
              data[0]['phonetics'] is List) {
            for (var p in data[0]['phonetics']) {
              if (p['text'] != null && p['text'].toString().isNotEmpty) {
                phonetic = p['text'];
                break;
              }
            }
          }
          if (phonetic.isNotEmpty) {
            phonetic = '($phonetic)';
          }
          var audioUrl = '';
          if (data[0]['phonetics'] != null && data[0]['phonetics'] is List) {
            for (var phonetic in data[0]['phonetics']) {
              if (phonetic['audio'] != null &&
                  phonetic['audio'].toString().isNotEmpty) {
                audioUrl = phonetic['audio'];
                break;
              }
            }
          }
          int totalMeanings = data[0]['meanings'].length;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(width: double.infinity, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          '$word $phonetic',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        if (audioUrl.isNotEmpty)
                          IconButton(
                            icon: Icon(Icons.volume_up),
                            onPressed: () async {
                              final player = AudioPlayer();
                              await player.play(UrlSource(audioUrl));
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: totalMeanings,
                      itemBuilder: (context, index) {
                        String partOfSpeech =
                            data[0]['meanings'][index]['partOfSpeech']
                                .toUpperCase();
                        List definitions =
                            data[0]['meanings'][index]['definitions'];
                        return Column(
                          children: [
                            ...definitions.map((def) {
                              String definition = def['definition'];
                              List<dynamic> synonymList = def['synonyms'];
                              List<dynamic> antonymList = def['antonyms'];
                              String synonyms = synonymList.isNotEmpty
                                  ? synonymList.join(', ')
                                  : 'No synonyms available';
                              String antonyms = antonymList.isNotEmpty
                                  ? antonymList.join(', ')
                                  : 'No antonyms available';
                              String example = def['example'] ?? 'No example available';
                              return Column(
                                children: [
                                  SizedBox(height: 8),
                                  ListTile(
                                    title: SelectableText(definition),
                                    leading: SizedBox(
                                      width: 40,
                                      child: SelectableText(
                                        partOfSpeech,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    subtitle: SelectableText(
                                      '\nSynonyms: $synonyms\nAntonyms: $antonyms\nExample: $example',
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            }),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: navBar(),
    );
  }
}

getData(String word) async {
  String url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';
  var res = await http.get(Uri.parse(url));
  var data;
  if (res.statusCode == 200) {
    data = jsonDecode(res.body);
  } else {
    throw 'Failed To Fetch Data\nPlease Check Your Internet Connection\nOr Check The Word Spelling';
  }
  return data;
}

navBar({Color colour = const Color.fromARGB(170, 0, 0, 0)}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: colour)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'App Developed by Nandakishore Basu',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colour,
            ),
          ),
          Text(
            'Email: nandakishore.basu@gmail.com',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colour,
            ),
          ),
        ],
      ),
    ),
  );
}

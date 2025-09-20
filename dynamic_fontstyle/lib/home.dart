import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

final availableFonts = GoogleFonts.asMap().keys.toList();

class _HomeState extends State<Home> {
  String text = 'This Text\'s Fontfamily is Going to Change';
  String selected = availableFonts[0];
  TextEditingController tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dynamic Fonts',
          style: GoogleFonts.getFont('Aladin'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SelectableText(
              text,
              style: GoogleFonts.getFont(selected, fontSize: 25),
            ),
            SizedBox(height: 10),
            TextField(
              controller: tec,
              onChanged: (value) {
                setState(() {
                  if (value != '') {
                    text = value;
                  } else {
                    text = 'Enter Something....';
                  }
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_snippet_outlined),
                hintText: 'Enter Your Custom Text Here',
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 25,
              width: double.infinity,
              child: Text(
                'Total Fonts : ${availableFonts.length}',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Annie Use Your Telescope',
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: availableFonts.length,
                itemBuilder: (context, index) {
                  final font = availableFonts[index];
                  return RadioGroup(
                    onChanged: (val) {
                      setState(() {
                        selected = val as String;
                      });
                    },
                    groupValue: selected,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Radio.adaptive(
                            side: BorderSide(
                              color: const Color.fromARGB(255, 106, 42, 118),
                              width: 2,
                            ),
                            value: font,
                            activeColor: Colors.blue,
                          ),
                        ),
                        SelectableText(
                          '${index + 1}. $font',
                          style: GoogleFonts.getFont(
                            font,
                            fontSize: 20,
                            color: const Color.fromARGB(255, 106, 42, 118),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

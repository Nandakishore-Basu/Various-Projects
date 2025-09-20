import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:external_path/external_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController tec = TextEditingController();
  String prompt = 'Welcome';
  Center x = Center(child: Text('Please Wait...'));
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width < 270 ? 200 : 250;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Image Generator AI'),
        leading: IconButton(
          onPressed: () {
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
          },
          icon: Icon(Icons.info_outline, color: Colors.blueAccent),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SizedBox(
                    width: width,
                    height: width,
                    child: Stack(
                      children: [
                        //Center(child: CircularProgressIndicator.adaptive()),
                        x,
                        Image(
                          image: NetworkImage(
                            'https://image.pollinations.ai/prompt/$prompt',
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            setState(() {
                              x = Center();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed To Load Image')),
                            );
                            return Center(
                              child: Text(
                                'Error\nPlease Check Internet Connection',
                              ),
                            );
                          },
                          loadingBuilder: (context, child, progress) =>
                              progress == null
                              ? child
                              : CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5),
                InkWell(
                  radius: 25,
                  borderRadius: BorderRadius.circular(20),
                  onTap: () async {
                    await downloadImage(
                      'https://image.pollinations.ai/prompt/$prompt',
                      context,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.download),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: tec,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Describe Your Image',
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (tec.text != '') {
                            setState(() {
                              prompt = tec.text;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please Give A Description'),
                              ),
                            );
                          }
                        });
                      },
                      child: Text('Generate'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

downloadImage(String url, BuildContext context) async {
  try {
    // Request storage permission
    await Permission.storage.request();
    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }

    if (!await Permission.storage.isGranted &&
        !await Permission.manageExternalStorage.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Storage permission denied.')));
      return;
    }

    // Download image data
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Directory? downloadsDir;
      String storagePath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOAD,
      );
      downloadsDir = Directory(storagePath);
      if (!await downloadsDir.exists()) {
        downloadsDir = await getExternalStorageDirectory();
        // ScaffoldMessenger.of(
        //   context,
        // ).showSnackBar(SnackBar(content: Text('Downloads folder not found.')));
      }
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpeg';
      final filePath = path.join(downloadsDir!.path, fileName);
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Image downloaded to $filePath')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to download image.')));
    }
  } catch (e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $e')));
  }
}

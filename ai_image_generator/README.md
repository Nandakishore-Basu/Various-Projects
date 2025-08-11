# The App Is Explicitly for Android Only

#### Due To :

```dart
downloadImage(String url, BuildContext context) async {
  try {
    // Request storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Storage permission denied.')));
      return;
    }

    // Download image data
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final downloadsDir = Directory('/storage/emulated/0/Download');
      if (!await downloadsDir.exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloads folder not found.')),
        );
        return;
      }
      final fileName = 'downloaded_image_${DateTime.now().millisecondsSinceEpoch}.jpeg';
      final filePath = path.join(downloadsDir.path, fileName);
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
```

#### This Code is for ANDROID ONLY

## App Developed By Nandakishore Basu
### AI Credits - pollinations.ai
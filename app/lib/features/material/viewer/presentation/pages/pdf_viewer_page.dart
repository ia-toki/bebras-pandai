part of '_pages.dart';

class PdfViewerPage extends StatefulWidget {
  final String? pdfUrl;
  final String? id;
  final String? title;
  final String? description;

  const PdfViewerPage({
    Key? key,
    required this.pdfUrl,
    this.id,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String basePath = "/storage/emulated/0/Android/data/com.toki.bebras_pandai/files/PDF_Download/";
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      saveFile(widget.pdfUrl.toString(), "${widget.id}.pdf");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          widget.title.toString(), // name
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await saveFile(widget.pdfUrl.toString(), "${widget.id}.pdf");
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'successfully saved to internal storage',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: basePath + widget.id.toString() + '.pdf',
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
          ),
        ],
      ),
    );
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        newPath = directory!.path + "/PDF_Download";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
          setState(() {
            pathPDF = saveFile.path;
          });
          print(pathPDF);
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}

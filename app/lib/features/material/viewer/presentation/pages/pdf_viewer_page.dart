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
  String basePath =
      "/storage/emulated/0/Android/data/com.toki.bebras_pandai/files/PDF_Download/";
  String localPathPdf = "";
  String remotePathPdf = "";

  @override
  void initState() {
    super.initState();
    if (File(basePath + widget.id.toString() + ".pdf").existsSync()) {
      setState(() {
        localPathPdf = basePath + widget.id.toString() + ".pdf";
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUrlPdfFile(widget.pdfUrl.toString());
    });
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   saveFile(widget.pdfUrl.toString(), "${widget.id}.pdf");
    // });
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
              try {
                await saveFile(remotePathPdf, "${widget.id}.pdf");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'successfully saved to internal storage',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.download_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          localPathPdf == ''
              ? LinearProgressIndicator()
              : PDFView(
                  filePath: localPathPdf,
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
          localPathPdf = saveFile.path;
        });
        print(localPathPdf);
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
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

  Future<void> fetchUrlPdfFile(String pathReference) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      String url = await storageRef.child(pathReference).getDownloadURL();
      setState(() {
        remotePathPdf = url;
      });
      saveFile(url, "${widget.id}.pdf");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

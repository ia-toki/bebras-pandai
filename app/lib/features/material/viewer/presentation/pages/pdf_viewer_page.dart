part of '_pages.dart';

class PdfViewerPage extends StatefulWidget {
  final String? pdfUrl;
  final String? id;
  final String? title;

  const PdfViewerPage({
    required this.pdfUrl,
    super.key,
    this.id,
    this.title,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String basePath =
      '/storage/emulated/0/Android/data/com.toki.bebras_pandai/files/PDF_Download/';
  String localPathPdf = '';
  String remotePathPdf = '';

  @override
  void initState() {
    super.initState();
    initializePdf();
  }

  Future<void> initializePdf() async {
    final file = File('$basePath${widget.id}.pdf');
    // ignore: avoid_slow_async_io
    if (await file.exists()) {
      setState(() {
        localPathPdf = file.path;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(
          widget.title.toString(), // name
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _generatePdf();
            },
            icon: const Icon(Icons.print_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _loadPdf(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading PDF'));
                } else {
                  return PDFView(
                    filePath: localPathPdf,
                    onError: (error) {
                      // Handle PDF view error
                    },
                    onPageError: (page, error) {
                      // Handle PDF view error on a specific page
                    },
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _loadPdf() async {
    if (localPathPdf == '') {
      await fetchUrlPdfFile(widget.pdfUrl.toString());
    }
    // Return a Future to satisfy the FutureBuilder
    return Future.value();
  }

  // Pdf Print
  Future<void> _generatePdf() async {
    try {
      final file = File('$basePath${widget.id}.pdf');
      final fileInByte = file.readAsBytesSync();
      await Printing.layoutPdf(onLayout: (_) => fileInByte);
    } catch (e) {
      // Do Nothing
    }
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      Directory? directory;
      directory = await getExternalStorageDirectory();
      var newPath = '';
      newPath = '${directory!.path}/PDF_Download';
      directory = Directory(newPath);

      final saveFile = File('${directory.path}/$fileName');
      if (kDebugMode) {
        print(saveFile.path);
      }
      final isDirectoryExist = directory.existsSync();
      if (!isDirectoryExist) {
        await directory.create(recursive: true);
      }
      if (isDirectoryExist) {
        await Dio().download(
          url,
          saveFile.path,
        );
        setState(() {
          localPathPdf = saveFile.path;
        });
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> fetchUrlPdfFile(String urlReference) async {
    try {
      final storageRef = FirebaseStorage.instance.refFromURL(urlReference);
      final url = await storageRef.getDownloadURL();
      setState(() {
        remotePathPdf = url;
      });
      await saveFile(url, '${widget.id}.pdf');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

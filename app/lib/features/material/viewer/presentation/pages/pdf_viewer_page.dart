part of '_pages.dart';

class PdfViewerPage extends StatefulWidget {
  final File? file;
  final String url;

  const PdfViewerPage({
    Key? key,
    this.file,
    required this.url,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late final MaterialViewerBloc _materialViewerBloc;
  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";

  @override
  void initState() {
    super.initState();
    _materialViewerBloc = get<MaterialViewerBloc>();
    print('oiuvh');

    // Fetch from local storage
    // fromAsset('assets/demo-link.pdf', 'demo.pdf').then((f) {
    //   setState(() {
    //     pathPDF = f.path;
    //   });
    // });

    // Trigger to fetch from URL
    // createFileOfPdfUrl().then((f) {
    //   setState(() {
    //     remotePDFpath = f.path;
    //   });
    // });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      final url = "http://www.pdf995.com/samples/pdf.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = ElevatedButton(
      child: Text("Tidak"),
      onPressed:  () {},
    );
    Widget continueButton = ElevatedButton(
      child: Text("Ya"),
      onPressed:  () {
        _materialViewerBloc.add(
          DialogDownloadPermitEvent(true),
        );
      },
    );  // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("File materi tidak ditemukan, ingin mengunduh?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final name = basename(widget.file.path);
    return BlocProvider(
      create: (context) => MaterialViewerBloc()..add(CheckMaterialFileEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffe6f6ff),
          title: Text(
            'name', // name
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await saveFile(widget.url, "sample.pdf");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'successfully saved to internal storage "PDF_Download" folder',
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
            BlocBuilder<MaterialViewerBloc, MaterialViewerState>(
                builder: (BuildContext context, state) {
                  String filePath = '';
                    print('test2');
                    print(state.toString());
                  if(state is MaterialFileExist) {
                    filePath = '/data/user/0/com.example.bebras.bebras_app_ui/app_flutter/pdfAcademy.pdf';
                  } else if (state is MaterialFileDoesNotExist){
                    Future.delayed(Duration.zero, () async {
                        showAlertDialog(context);
                    });
                    // _materialViewerBloc.add(
                    //   DialogDownloadPermitEvent(true),
                    // );
                    // setState(() {
                    //     // remotePDFpath = f.path;
                    // });
                    filePath = '/';
                  } else if (state is MaterialFileDownloaded) {
                    return PDFView(
                        filePath: filePath,
                        onError: (error) {
                          print(error.toString());
                        },
                        onPageError: (page, error) {
                          print('$page: ${error.toString()}');
                        },
                        // onViewCreated: (PDFViewController pdfViewController) {
                        //   _controller.complete(pdfViewController);
                        // },
                        // onPageChanged: (int page, int total) {
                        //   print('page change: $page/$total');
                        // },
                      );
                    // saveFile();
                  } else if (state is UserDisagreeToDownload) {

                  }
              return Container();
              //   PDFView(
              //   filePath: filePath,
              //   onError: (error) {
              //     print(error.toString());
              //   },
              //   onPageError: (page, error) {
              //     print('$page: ${error.toString()}');
              //   },
              //   // onViewCreated: (PDFViewController pdfViewController) {
              //   //   _controller.complete(pdfViewController);
              //   // },
              //   // onPageChanged: (int page, int total) {
              //   //   print('page change: $page/$total');
              //   // },
              // );
            }),
          ],
        ),
      ),
    );
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/PDF_Download";
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

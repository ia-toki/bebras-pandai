import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'view_pembahasan_soal_model.dart';
export 'view_pembahasan_soal_model.dart';

class ViewPembahasanSoalWidget extends StatefulWidget {
  const ViewPembahasanSoalWidget({
    Key? key,
    String? title,
    String? url,
  })  : this.title = title ?? 'Undefined',
        this.url = url ?? 'https://www.google.com/',
        super(key: key);

  final String title;
  final String url;

  @override
  _ViewPembahasanSoalWidgetState createState() =>
      _ViewPembahasanSoalWidgetState();
}

class _ViewPembahasanSoalWidgetState extends State<ViewPembahasanSoalWidget> {
  late ViewPembahasanSoalModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewPembahasanSoalModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            widget.title,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: FlutterFlowPdfViewer(
                      assetPath: 'assets/pdfs/Bebras-Challenge-2016_Siaga.pdf',
                      width: MediaQuery.of(context).size.width * 1.0,
                      height: 831.0,
                      horizontalScroll: false,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0.96, -0.97),
                child: FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).primary,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: Colors.white,
                  icon: Icon(
                    Icons.download_rounded,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                  onPressed: () async {
                    await launchURL(widget.url);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

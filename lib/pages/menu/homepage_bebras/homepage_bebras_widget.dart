import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'homepage_bebras_model.dart';
export 'homepage_bebras_model.dart';

class HomepageBebrasWidget extends StatefulWidget {
  const HomepageBebrasWidget({Key? key}) : super(key: key);

  @override
  _HomepageBebrasWidgetState createState() => _HomepageBebrasWidgetState();
}

class _HomepageBebrasWidgetState extends State<HomepageBebrasWidget> {
  late HomepageBebrasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomepageBebrasModel());

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
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 100.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/bebras-pandai-w0kkqx/assets/owbmfnwlu9m6/bebras-banner-2.png',
                    width: 300.0,
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                ),
                Divider(
                  height: 60.0,
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Selamat Datang\n',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 24.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        TextSpan(
                          text: 'Dwika,',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 24.0,
                          ),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('ListPembahasanSoal');
                  },
                  text: 'Lihat Materi',
                  options: FFButtonOptions(
                    width: 300.0,
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('ListPembahasanSoal');
                  },
                  text: 'Cetak Materi',
                  options: FFButtonOptions(
                    width: 300.0,
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Divider(
                  height: 30.0,
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed('QuizModuleList');
                  },
                  text: 'Ikut Quiz',
                  options: FFButtonOptions(
                    width: 300.0,
                    height: 40.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primaryText,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 3.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Divider(
                  height: 90.0,
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                Container(
                  width: 300.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).accent4,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await launchURL('https://bebras.or.id/v3/');
                      },
                      child: Text(
                        'Tentang Bebras Indonesia',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).info,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

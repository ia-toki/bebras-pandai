import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'under_construction_bebras_model.dart';
export 'under_construction_bebras_model.dart';

class UnderConstructionBebrasWidget extends StatefulWidget {
  const UnderConstructionBebrasWidget({Key? key}) : super(key: key);

  @override
  _UnderConstructionBebrasWidgetState createState() =>
      _UnderConstructionBebrasWidgetState();
}

class _UnderConstructionBebrasWidgetState
    extends State<UnderConstructionBebrasWidget> {
  late UnderConstructionBebrasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UnderConstructionBebrasModel());

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
                  height: 20.0,
                  thickness: 1.0,
                  color: FlutterFlowTheme.of(context).accent4,
                ),
                Text(
                  'Maaf fitur ini sedang dalam perbaikan ',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/bebras-pandai-w0kkqx/assets/rus62dyyix8r/mascot-bebras-indonesia.png',
                    width: 300.0,
                    height: 400.0,
                    fit: BoxFit.cover,
                  ),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    context.safePop();
                  },
                  text: 'Kembali',
                  options: FFButtonOptions(
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).accent1,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    elevation: 1.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
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

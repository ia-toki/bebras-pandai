import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'quiz_module_detail_model.dart';
export 'quiz_module_detail_model.dart';

class QuizModuleDetailWidget extends StatefulWidget {
  const QuizModuleDetailWidget({Key? key}) : super(key: key);

  @override
  _QuizModuleDetailWidgetState createState() => _QuizModuleDetailWidgetState();
}

class _QuizModuleDetailWidgetState extends State<QuizModuleDetailWidget> {
  late QuizModuleDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => QuizModuleDetailModel());

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Kuis Mingguan',
            style: FlutterFlowTheme.of(context).titleLarge,
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    shape: BoxShape.rectangle,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Soal 1',
                              style: FlutterFlowTheme.of(context).titleLarge,
                            ),
                            Text(
                              'Berang-berang mengembangkan suatu “bahasa” untuk melipat kertas. Bahasa ini dapat digunakan untuk menjelaskan bagaimana setiap lembaran kertas dapat dilipat dengan sisi-sisi lurus. Salah satu perintah dalam bahasa ini adalah fold.',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            Text(
                              'e = fold(a, b) artinya:',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            Text(
                              'anda melipat sisi a selembar kertas agar menempel pada sisi b. Dengan perintah ini, Anda membuat sisi baru, yaitu sebuah garis yang membentuk lipatan, yang dinamakan e. Contoh:',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: FlutterFlowExpandedImageView(
                                      image: CachedNetworkImage(
                                        imageUrl:
                                            'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-folding.png',
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: 'imageTag1',
                                      useHeroAnimation: true,
                                    ),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: 'imageTag1',
                                transitionOnUserGestures: true,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-folding.png',
                                    width:
                                        MediaQuery.of(context).size.width * 1.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'Harap dicatat bahwa kertas ada di meja selama pelipatan, dan panjang sisi b adalah dua kali panjang sisi a.',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            Text(
                              'Bagaimana tampak bentuk kertas (a, b, c, d) setelah menjalankan ketiga perintah di atas?',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                            Text(
                              'e = fold(c, a); f = fold(c, d); g = fold(a, f)',
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                        Divider(
                          thickness: 0.0,
                          color: FlutterFlowTheme.of(context).accent4,
                        ),
                        ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowRadioButton(
                                  options: [''].toList(),
                                  onChanged: (val) => setState(() {}),
                                  controller:
                                      _model.radioButtonValueController1 ??=
                                          FormFieldController<String>(null),
                                  optionHeight: 32.0,
                                  textStyle:
                                      FlutterFlowTheme.of(context).labelMedium,
                                  buttonPosition: RadioButtonPosition.left,
                                  direction: Axis.vertical,
                                  radioButtonColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveRadioButtonColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  toggleable: true,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingA.png',
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: 'imageTag2',
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'imageTag2',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingA.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowRadioButton(
                                  options: [''].toList(),
                                  onChanged: (val) => setState(() {}),
                                  controller:
                                      _model.radioButtonValueController2 ??=
                                          FormFieldController<String>(null),
                                  optionHeight: 32.0,
                                  textStyle:
                                      FlutterFlowTheme.of(context).labelMedium,
                                  selectedTextStyle:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  buttonPosition: RadioButtonPosition.left,
                                  direction: Axis.vertical,
                                  radioButtonColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveRadioButtonColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  toggleable: false,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingB.png',
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: 'imageTag3',
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'imageTag3',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingB.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowRadioButton(
                                  options: [''].toList(),
                                  onChanged: (val) => setState(() {}),
                                  controller:
                                      _model.radioButtonValueController3 ??=
                                          FormFieldController<String>(null),
                                  optionHeight: 32.0,
                                  textStyle:
                                      FlutterFlowTheme.of(context).labelMedium,
                                  selectedTextStyle:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  buttonPosition: RadioButtonPosition.left,
                                  direction: Axis.vertical,
                                  radioButtonColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveRadioButtonColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  toggleable: false,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingC.png',
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: 'imageTag4',
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'imageTag4',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingC.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                FlutterFlowRadioButton(
                                  options: [''].toList(),
                                  onChanged: (val) => setState(() {}),
                                  controller:
                                      _model.radioButtonValueController4 ??=
                                          FormFieldController<String>(null),
                                  optionHeight: 32.0,
                                  textStyle:
                                      FlutterFlowTheme.of(context).labelMedium,
                                  selectedTextStyle:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                  buttonPosition: RadioButtonPosition.left,
                                  direction: Axis.vertical,
                                  radioButtonColor:
                                      FlutterFlowTheme.of(context).primary,
                                  inactiveRadioButtonColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                  toggleable: false,
                                  horizontalAlignment: WrapAlignment.start,
                                  verticalAlignment: WrapCrossAlignment.start,
                                ),
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingD.png',
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: 'imageTag5',
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: 'imageTag5',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'http://bebras.or.id/v3/wp-content/uploads/2017/07/paper-foldingD.png',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 50.0,
                    fillColor: Color(0xFF827AE1),
                    icon: Icon(
                      Icons.chevron_left_sharp,
                      color: Color(0x00000000),
                      size: 24.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Text(
                            'Question 2/3',
                            style: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        LinearPercentIndicator(
                          percent: 0.6,
                          lineHeight: 12.0,
                          animation: true,
                          progressColor: Color(0xFF827AE1),
                          backgroundColor: Color(0xFFE0E3E7),
                          barRadius: Radius.circular(24.0),
                          padding: EdgeInsets.zero,
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 50.0,
                    fillColor: Color(0xFF827AE1),
                    icon: Icon(
                      Icons.chevron_right_sharp,
                      color: Color(0x00000000),
                      size: 24.0,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'value_selector_model.dart';
export 'value_selector_model.dart';

class ValueSelectorWidget extends StatefulWidget {
  const ValueSelectorWidget({
    Key? key,
    this.gameRef,
  }) : super(key: key);

  final DocumentReference? gameRef;

  @override
  _ValueSelectorWidgetState createState() => _ValueSelectorWidgetState();
}

class _ValueSelectorWidgetState extends State<ValueSelectorWidget> {
  late ValueSelectorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ValueSelectorModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GamesRecord>(
      stream: GamesRecord.getDocument(widget.gameRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50.0,
              height: 50.0,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primary,
              ),
            ),
          );
        }
        final containerGamesRecord = snapshot.data!;
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
          ),
          child: FutureBuilder<ApiCallResponse>(
            future: AllQuestionsCall.call(
              category: containerGamesRecord.currentCategory,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                );
              }
              final listViewAllQuestionsResponse = snapshot.data!;
              return Builder(
                builder: (context) {
                  final questions = getJsonField(
                    listViewAllQuestionsResponse.jsonBody,
                    r'''$''',
                  ).toList();
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: questions.length,
                    itemBuilder: (context, questionsIndex) {
                      final questionsItem = questions[questionsIndex];
                      return Stack(
                        children: [
                          if (containerGamesRecord.answeredQuestions
                              .contains(getJsonField(
                            questionsItem,
                            r'''$.id''',
                          )))
                            Align(
                              alignment: AlignmentDirectional(-0.15, -0.22),
                              child: Container(
                                width: double.infinity,
                                height: 62.0,
                                decoration: BoxDecoration(
                                  color:
                                      FlutterFlowTheme.of(context).customColor3,
                                ),
                              ),
                            ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await widget.gameRef!.update({
                                  ...createGamesRecordData(
                                    questionMode: true,
                                    currentValue: getJsonField(
                                      questionsItem,
                                      r'''$.value''',
                                    ),
                                    currentQuestion: getJsonField(
                                      questionsItem,
                                      r'''$.question''',
                                    ).toString(),
                                    currentAnswer: getJsonField(
                                      questionsItem,
                                      r'''$.answer''',
                                    ).toString(),
                                    selectMode: false,
                                  ),
                                  'answered_questions': FieldValue.arrayUnion([
                                    getJsonField(
                                      questionsItem,
                                      r'''$.id''',
                                    )
                                  ]),
                                });

                                context.goNamed(
                                  'GamePage',
                                  queryParameters: {
                                    'gameRef': serializeParam(
                                      widget.gameRef,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                      duration: Duration(milliseconds: 0),
                                    ),
                                  },
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  getJsonField(
                                    questionsItem,
                                    r'''$.value''',
                                  ).toString(),
                                  style: FlutterFlowTheme.of(context)
                                      .headlineSmall,
                                ),
                                tileColor: Color(0xFFF5F5F5),
                                dense: false,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 8.0, 15.0, 8.0),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'answer_component_model.dart';
export 'answer_component_model.dart';

class AnswerComponentWidget extends StatefulWidget {
  const AnswerComponentWidget({
    Key? key,
    this.answer,
  }) : super(key: key);

  final String? answer;

  @override
  _AnswerComponentWidgetState createState() => _AnswerComponentWidgetState();
}

class _AnswerComponentWidgetState extends State<AnswerComponentWidget> {
  late AnswerComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AnswerComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        widget.answer!,
        style: FlutterFlowTheme.of(context).headlineMedium,
      ),
    );
  }
}

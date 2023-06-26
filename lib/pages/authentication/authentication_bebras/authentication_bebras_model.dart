import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthenticationBebrasModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress_register widget.
  TextEditingController? emailAddressRegisterController;
  String? Function(BuildContext, String?)?
      emailAddressRegisterControllerValidator;
  // State field(s) for password_register widget.
  TextEditingController? passwordRegisterController;
  late bool passwordRegisterVisibility;
  String? Function(BuildContext, String?)? passwordRegisterControllerValidator;
  // State field(s) for passwordConfirmation_register widget.
  TextEditingController? passwordConfirmationRegisterController;
  late bool passwordConfirmationRegisterVisibility;
  String? Function(BuildContext, String?)?
      passwordConfirmationRegisterControllerValidator;
  // State field(s) for emailAddress_login widget.
  TextEditingController? emailAddressLoginController;
  String? Function(BuildContext, String?)? emailAddressLoginControllerValidator;
  // State field(s) for password_login widget.
  TextEditingController? passwordLoginController;
  late bool passwordLoginVisibility;
  String? Function(BuildContext, String?)? passwordLoginControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordRegisterVisibility = false;
    passwordConfirmationRegisterVisibility = false;
    passwordLoginVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressRegisterController?.dispose();
    passwordRegisterController?.dispose();
    passwordConfirmationRegisterController?.dispose();
    emailAddressLoginController?.dispose();
    passwordLoginController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

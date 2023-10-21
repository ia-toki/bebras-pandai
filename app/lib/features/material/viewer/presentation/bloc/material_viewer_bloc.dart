import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

part 'material_viewer_event.dart';
part 'material_viewer_state.dart';

@injectable
@singleton
class MaterialViewerBloc
    extends Bloc<MaterialViewerEvent, MaterialViewerState> {
  MaterialViewerBloc() : super(MaterialFileInitialization()) {
    on<CheckMaterialFileEvent>(checkIsMaterialFileExist);
    on<DialogDownloadPermitEvent>(dialogPermitDownloadFile);
  }

  FutureOr<void> checkIsMaterialFileExist(
      CheckMaterialFileEvent state,
    Emitter<MaterialViewerState> emit,
  ) async {
    bool isFile = await File("/data/user/0/com.example.bebras.bebras_app_ui/app_flutter/pdfAcademy.pdf").exists();
    if(isFile) {
      emit(MaterialFileExist());
    } else {
      emit(MaterialFileDoesNotExist());
    }
    // final creds = await _googleSignIn.signInSilently();
    //
    // if (creds != null) {
    //   emit(UserAuthenticated());
    // } else {
    //   emit(UserUnauthenticated());
    // }
  }

  FutureOr<void> dialogPermitDownloadFile(
      DialogDownloadPermitEvent state,
      Emitter<MaterialViewerState> emit,
      ) async {
    if(state.userPermission) {
      String url = 'https://firebasestorage.googleapis.com/v0/b/toki-bebras-proto.appspot.com/o/buku_bebras%2FBebras-Challenge-2016_Penegak.pdf';
      emit(UserAgreeToDownload());
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
          newPath = newPath + "/Materi_Bebras";
          print(newPath);
          directory = Directory(newPath);

          File saveFile = File(directory.path + "/pdfAcademy.pdf");
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
            emit(MaterialFileDownloaded());
          }
        }
        // return true;
      } catch (e) {
        // return false;
      }
    } else {
      emit(UserDisagreeToDownload());
    }
    // final creds = await _googleSignIn.signInSilently();
    //
    // if (creds != null) {
    //   emit(UserAuthenticated());
    // } else {
    //   emit(UserUnauthenticated());
    // }
  }
}

Future<bool> _requestPermission(Permission permission) async {
  if (await permission.isGranted) {
    return true;
  } else {
  print('lolos234');
    var result = await permission.request();
    if (result == PermissionStatus.granted) {
      return true;
    }
  }
  return false;
}

part of 'material_viewer_bloc.dart';

class MaterialViewerState extends Equatable {
  final String pdfPath;
  const MaterialViewerState({
    this.pdfPath = '',
  });

  @override
  List<Object> get props => [];
}

class MaterialFileInitialization extends MaterialViewerState {}

class UserAgreeToDownload extends MaterialViewerState {}

class UserDisagreeToDownload extends MaterialViewerState {}

class MaterialFileExist extends MaterialViewerState {}

class MaterialFileDoesNotExist extends MaterialViewerState {}

class MaterialFileDownloaded extends MaterialViewerState {}

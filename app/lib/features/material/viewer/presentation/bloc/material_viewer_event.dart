part of 'material_viewer_bloc.dart';

abstract class MaterialViewerEvent extends Equatable {
  const MaterialViewerEvent();

  @override
  List<Object> get props => [];
}

class CheckMaterialFileEvent extends MaterialViewerEvent {}

class DialogDownloadPermitEvent extends MaterialViewerEvent {
  final bool userPermission;
  const DialogDownloadPermitEvent(this.userPermission);
}

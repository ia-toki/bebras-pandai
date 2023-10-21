part of 'material_menu_bloc.dart';

abstract class MaterialMenuEvent extends Equatable {
  const MaterialMenuEvent();

  @override
  List<Object> get props => [];
}

class CheckMaterialFileEvent extends MaterialMenuEvent {}

class DialogDownloadPermitEvent extends MaterialMenuEvent {
  final bool userPermission;
  const DialogDownloadPermitEvent(this.userPermission);
}

class FetchMaterialDocumentEvent extends MaterialMenuEvent {
  const FetchMaterialDocumentEvent({
    this.challenge_group,
    this.description,
    this.file_format,
    this.is_printable = true,
    this.source_urls,
    this.staging_url,
    this.title,
    this.url,
  });
  final String? challenge_group;
  final String? description;
  final String? file_format;
  final bool is_printable;
  final List<String?>? source_urls;
  final String? staging_url;
  final String? title;
  final String? url;
  @override
  List<Object> get props => [{
    challenge_group,
    description,
    file_format,
    is_printable,
    source_urls,
    staging_url,
    title,
    url,
  }];
}

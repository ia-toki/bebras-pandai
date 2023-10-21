import 'dart:async';

import '../../presentation/repositories/material_document_repo.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../modal/materialDocument.dart';

part 'material_menu_event.dart';
part 'material_menu_state.dart';

@injectable
@singleton
class MaterialMenuBloc
    extends Bloc<MaterialMenuEvent, MaterialMenuState> {
  final MaterialDocumentRepository _materialDocumentRepository;
  MaterialMenuBloc(this._materialDocumentRepository) : super(MaterialFileInitialization()) {
    on<FetchMaterialDocumentEvent>(handleFetchDocument);
  }

  FutureOr<void> handleFetchDocument(
      FetchMaterialDocumentEvent event,
    Emitter<MaterialMenuState> emit,
  ) async {
    var materialDoc = await _materialDocumentRepository.fetchDocument(docId: 'docId');
    emit(
      state.copyWith(
        materialDocument: MaterialDocument.fromJson(materialDoc),
      ),
    );
  }
}

part of 'material_menu_bloc.dart';

class MaterialMenuState extends Equatable {
  final Object? materialDocument;
  const MaterialMenuState({
    this.materialDocument = '',
  });

  MaterialMenuState copyWith({
    MaterialDocument? materialDocument,
  }) {
    return MaterialMenuState(
      materialDocument: materialDocument ?? this.materialDocument,
    );
  }

  @override
  List<Object> get props => [];
}

class MaterialFileInitialization extends MaterialMenuState {}

class AllMaterialFetchSuccess extends MaterialMenuState {}

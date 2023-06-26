import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GameScoresRecord extends FirestoreRecord {
  GameScoresRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "game" field.
  DocumentReference? _game;
  DocumentReference? get game => _game;
  bool hasGame() => _game != null;

  // "score" field.
  int? _score;
  int get score => _score ?? 0;
  bool hasScore() => _score != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _game = snapshotData['game'] as DocumentReference?;
    _score = castToType<int>(snapshotData['score']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('game_scores');

  static Stream<GameScoresRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GameScoresRecord.fromSnapshot(s));

  static Future<GameScoresRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GameScoresRecord.fromSnapshot(s));

  static GameScoresRecord fromSnapshot(DocumentSnapshot snapshot) =>
      GameScoresRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GameScoresRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GameScoresRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GameScoresRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GameScoresRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGameScoresRecordData({
  DocumentReference? user,
  DocumentReference? game,
  int? score,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'game': game,
      'score': score,
    }.withoutNulls,
  );

  return firestoreData;
}

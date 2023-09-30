import 'package:either_dart/either.dart';
import '../../errors/failure.dart';

abstract class UseCase<T, A> {
  Future<Either<Failure, T?>> execute([A args]);
}

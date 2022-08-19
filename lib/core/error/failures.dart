import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

// No internet connection
class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// Server Error (api doesn't return data from server)
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// No database or no data in database
class EmptyCashFailure extends Failure {
  @override
  List<Object?> get props => [];
}

// throw NoInternetException ();
// return Left(OfflineFailure());

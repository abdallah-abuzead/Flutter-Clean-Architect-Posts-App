import 'package:bloc/bloc.dart';
import 'package:clean_architecture_posts_app/core/strings/messages.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/usecases/delete_post.dart';
import '../../../domain/usecases/update_post.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

class AddDeleteUpdatePostBloc extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addPost;
  final UpdatePostUseCase updatePost;
  final DeletePostUseCase deletePost;
  AddDeleteUpdatePostBloc({
    required this.addPost,
    required this.updatePost,
    required this.deletePost,
  }) : super(AddDeleteUpdatePostInitial()) {
    // on<DeletePostEvent>((event, emit) => emit(LoadingAddDeleteUpdatePostState()));
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  AddDeleteUpdatePostState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdatePostState(message: _mapFailureToMessage(failure)),
      (_) => MessageAddDeleteUpdatePostState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FALILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FALILURE_MESSAGE;
      default:
        return 'Unexpected error, Please try again later.';
    }
  }
}

part of 'bookmarks_cubit.dart';

sealed class BookmarksState extends Equatable {
  const BookmarksState();

  @override
  List<Object?> get props => [];
}

final class BookmarksInitialState extends BookmarksState {
  const BookmarksInitialState();
}

final class GetBookmarksLoadingState extends BookmarksState {
  const GetBookmarksLoadingState();
}

final class GetBookmarksSuccessState extends BookmarksState {
  const GetBookmarksSuccessState(this.bookmarks);

  final List<BookmarkModel> bookmarks;

  @override
  List<Object?> get props => [bookmarks];
}

final class GetBookmarksFailureState extends BookmarksState {
  const GetBookmarksFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class RemoveBookmarkSuccessState extends BookmarksState {
  const RemoveBookmarkSuccessState(this.articleId);

  final String articleId;

  @override
  List<Object?> get props => [articleId];
}

final class RemoveBookmarkFailureState extends BookmarksState {
  const RemoveBookmarkFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class RestoreBookmarkSuccessState extends BookmarksState {
  const RestoreBookmarkSuccessState(this.articleId);

  final String articleId;

  @override
  List<Object?> get props => [articleId];
}

final class RestoreBookmarkFailureState extends BookmarksState {
  const RestoreBookmarkFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

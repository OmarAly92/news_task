part of 'article_details_cubit.dart';

sealed class ArticleDetailsState extends Equatable {
  const ArticleDetailsState();

  @override
  List<Object?> get props => [];
}

final class ArticleDetailsInitialState extends ArticleDetailsState {
  const ArticleDetailsInitialState();
}

final class GetArticleLoadingState extends ArticleDetailsState {
  const GetArticleLoadingState();
}

final class GetArticleSuccessState extends ArticleDetailsState {
  const GetArticleSuccessState();
}

final class GetArticleFailureState extends ArticleDetailsState {
  const GetArticleFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class ArticleUnavailableState extends ArticleDetailsState {
  const ArticleUnavailableState({this.reason});

  final String? reason;

  @override
  List<Object?> get props => [reason];
}

final class GetRelatedSuccessState extends ArticleDetailsState {
  const GetRelatedSuccessState();
}

final class ChangeGalleryPageSuccessState extends ArticleDetailsState {
  const ChangeGalleryPageSuccessState(this.index);

  final int index;

  @override
  List<Object?> get props => [index];
}

final class ToggleBookmarkSuccessState extends ArticleDetailsState {
  const ToggleBookmarkSuccessState(this.isBookmarked);

  final bool isBookmarked;

  @override
  List<Object?> get props => [isBookmarked];
}

final class ToggleBookmarkFailureState extends ArticleDetailsState {
  const ToggleBookmarkFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class SyncBookmarkSuccessState extends ArticleDetailsState {
  const SyncBookmarkSuccessState(this.isBookmarked);

  final bool isBookmarked;

  @override
  List<Object?> get props => [isBookmarked];
}

final class UpdateReactionSuccessState extends ArticleDetailsState {
  const UpdateReactionSuccessState(this.isLiked, this.likes);

  final bool? isLiked;
  final int? likes;

  @override
  List<Object?> get props => [isLiked, likes];
}

final class ToggleLikeSuccessState extends ArticleDetailsState {
  const ToggleLikeSuccessState({
    required this.isLiked,
    required this.wasConflict,
  });

  final bool isLiked;
  final bool wasConflict;

  @override
  List<Object?> get props => [isLiked, wasConflict];
}

final class ToggleLikeQueuedState extends ArticleDetailsState {
  const ToggleLikeQueuedState();
}

final class ToggleLikeFailureState extends ArticleDetailsState {
  const ToggleLikeFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

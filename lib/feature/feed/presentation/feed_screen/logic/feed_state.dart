part of 'feed_cubit.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object?> get props => [];
}

final class FeedInitialState extends FeedState {
  const FeedInitialState();
}

final class GetTopicsSuccessState extends FeedState {
  const GetTopicsSuccessState();
}

final class GetTopicsFailureState extends FeedState {
  const GetTopicsFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class GetFeedLoadingState extends FeedState {
  const GetFeedLoadingState();
}

final class GetFeedSuccessState extends FeedState {
  const GetFeedSuccessState();
}

final class GetFeedFailureState extends FeedState {
  const GetFeedFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class LoadMoreLoadingState extends FeedState {
  const LoadMoreLoadingState();
}

final class LoadMoreSuccessState extends FeedState {
  const LoadMoreSuccessState();
}

final class LoadMoreFailureState extends FeedState {
  const LoadMoreFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class RefreshFeedSuccessState extends FeedState {
  const RefreshFeedSuccessState(this.at);

  final DateTime at;

  @override
  List<Object?> get props => [at];
}

final class RefreshFeedFailureState extends FeedState {
  const RefreshFeedFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class SelectTopicSuccessState extends FeedState {
  const SelectTopicSuccessState(this.topicId);

  final String? topicId;

  @override
  List<Object?> get props => [topicId];
}

final class NewStoriesAvailableState extends FeedState {
  const NewStoriesAvailableState(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}

final class UpdateArticleSuccessState extends FeedState {
  const UpdateArticleSuccessState(this.article);

  final ArticleModel article;

  @override
  List<Object?> get props => [article];
}

final class ToggleBookmarkSuccessState extends FeedState {
  const ToggleBookmarkSuccessState(this.articleId, this.isBookmarked);

  final String articleId;
  final bool isBookmarked;

  @override
  List<Object?> get props => [articleId, isBookmarked];
}

final class ToggleBookmarkFailureState extends FeedState {
  const ToggleBookmarkFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class SyncBookmarksSuccessState extends FeedState {
  const SyncBookmarksSuccessState(this.bookmarkedIds);

  final Set<String> bookmarkedIds;

  @override
  List<Object?> get props => [bookmarkedIds];
}

final class ToggleLikeSuccessState extends FeedState {
  const ToggleLikeSuccessState(
    this.articleId, {
    required this.isLiked,
    required this.wasConflict,
  });

  final String articleId;
  final bool isLiked;
  final bool wasConflict;

  @override
  List<Object?> get props => [articleId, isLiked, wasConflict];
}

final class ToggleLikeQueuedState extends FeedState {
  const ToggleLikeQueuedState(this.articleId);

  final String articleId;

  @override
  List<Object?> get props => [articleId];
}

final class ToggleLikeFailureState extends FeedState {
  const ToggleLikeFailureState({required this.failure});

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

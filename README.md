# News Feed

A Flutter news-feed app built for the take-home task: paginated feed, debounced search with filters, article details, bookmarks, optimistic reactions, an offline outbox with server sync, and an offline cache for the feed and articles. No real backend — everything is served by an in-app mock server that reads the JSON assets in `json_data/`.

- [Demo](#demo)
- [Setup](#setup)
- [Architecture](#architecture)
- [Project structure](#project-structure)
- [How to add a feature](#how-to-add-a-feature)
- [Features](#features)
  - [App nav bar](#app-nav-bar)
  - [Feed](#feed)
  - [Search](#search)
  - [Article details](#article-details)
  - [Bookmarks](#bookmarks)
  - [Reactions](#reactions)
  - [Sync (offline outbox)](#sync-offline-outbox)
  - [Offline cache](#offline-cache)
- [Mock API](#mock-api)
- [Local database](#local-database)
- [Tests](#tests)
- [Accessibility](#accessibility)

---

## Demo

https://github.com/user-attachments/assets/dcfd2f90-92bd-4751-930f-3342e1c21a09

Feed pagination, pull to refresh, debounced search, article details, bookmark persistence, optimistic likes, and offline behaviour. Direct file: [video/demo-video.mp4](video/demo-video.mp4).

---

## Setup

Requirements: Flutter with Dart `^3.12`.

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # drift codegen (already committed)
flutter run
```

The app runs against the mock API by default. To point it at a real backend:

```bash
flutter run --dart-define=USE_MOCK_API=false --dart-define=BASE_URL=https://your.api
```

Useful commands:

```bash
flutter analyze
flutter test
dart run easy_localization:generate -S assets/translations -O lib/core/helpers/localization -o locale_keys.g.dart -f keys
```

---

## Architecture

Three layers per feature, one dependency direction (`presentation → data`, `feature → core`, never the reverse):

```
UI (StatelessWidget)  ──reads──▶  Cubit (flutter_bloc)  ──calls──▶  Repository (interface)
                                                                          │
                                                       ┌──────────────────┴──────────────────┐
                                                       ▼                                     ▼
                                              RemoteDataSource                      LocalDataSource
                                              (ApiConsumer / Dio)                   (drift DAO / CacheHelper)
```

- **State management** — `Cubit` only (no event classes). One sealed state class per cubit, one `Loading/Success/Failure` triple per cubit method. The cubit owns the data (`articles`, `results`, …) and all widget state (controllers, scroll, timers); success states carry no payload.
- **Result type** — Repositories return `FutureResult<T>` = `Future<Result<T, Failure>>`. No exceptions cross the repository boundary.
- **Errors** — `Failure` hierarchy in `core/error_handling`: `ServerFailure` (Dio / HTTP, incl. `noNetwork()`), `LocalFailure` (drift/sqlite), `MappingFailure` (JSON). Data sources never catch; repositories catch `Failure` and wrap it in `Result.failure`.
- **Networking** — `ApiConsumer` interface; `DioConsumer` for real HTTP, `MockApiConsumer` for the in-app mock server. Data sources depend only on the interface.
- **Persistence** — `drift` (SQLite). Tables + DAOs live in `core/database`; features map entities ↔ models in a `LocalDataSource`, so drift types never reach repositories or UI.
- **DI** — `get_it` (`core/utils/service_locator.dart`) — one `_<feature>FeatureSetup()` per feature. Cubits are factories, repositories/data sources are lazy singletons.
- **Routing** — `AppRouter.generateRoute` — the route case creates the `BlocProvider`; screens never create their own cubit. Tab screens are provided by `AppNavBarBody`.
- **UI kit** — `core/widgets` wrappers (`AppText`, `AppScaffold`, `GlobalAppbar`, `AppTextField`, `PrimaryButton`, spacing widgets, …), `AppTextStyle` for typography, `context.skin` for colors. `SkinCubit` resolves `LightSkin`/`DarkSkin` from the platform brightness on launch and reacts to `didChangePlatformBrightness`, so the app follows the system setting live; an explicit `setSkin`/`toggleSkin` choice is persisted in `CacheHelper` and overrides the system until `followSystem()` is called. The feed app bar has a `ThemeToggleButton` (`core/app_themes/widgets/`) that opens `ThemePickerSheet` with Light / Dark / System options; the icon reflects the current preference. Overlay badges on images use `AppBadge.overlay` (opaque surface fill) so they stay legible over photos in both themes.
- **Localization** — `easy_localization`, `assets/translations/{en,ar}.json`, generated `LocaleKeys`. Every user-facing string goes through `LocaleKeys.x.tr()`.

### Cross-feature communication

Features never import each other's cubits. When two screens need the same fact, the **repository** owns the truth and exposes a stream:

- `BookmarksRepository.watchBookmarkedIds()` — a drift `watch()`; feed and article cubits overlay it on their articles, so bookmarking anywhere updates everywhere.
- `ReactionsRepository.updates` — a broadcast stream; a confirmed/reconciled like published by one cubit patches the other.
- `NetworkCubit.onRestored` — fires when connectivity returns; the feed refreshes and `SyncCubit` flushes the outbox.

---

## Project structure

```
lib/
  main.dart / my_app.dart            bootstrap, EasyLocalization, theme, global cubits
  core/
    api/
      api_request_helpers/           ApiConsumer, DioConsumer, EndPoints
      models/                        GlobalResponse (data + isCached + cachedAt)
      mock/                          MockApiConsumer, MockServer, MockStore, MockAssetLoader
    app_routes/                      AppRouter, RoutesStrings
    app_themes/                      skins (light/dark), AppTextStyle, AppMotion, AppShapes
    database/
      app_database.dart              the one @DriftDatabase
      tables/<table>/                <table>_table.dart + <table>_dao.dart
    error_handling/                  Failure hierarchy, Dio/drift error mappers
    helpers/                         cache (SharedPreferences), network status, localization, logging, format
    utils/                           service_locator, constants, extensions, debouncer
    widgets/                         reusable UI kit
  feature/
    <feature>/
      data/
        data_source/<feature>_remote_data_source.dart
        data_source/<feature>_local_data_source.dart      (only if the feature persists locally)
        model/<x>_model.dart                              (all fields nullable, fromJson/toJson/fromDB)
        model/params/<method>_params.dart                 (one params class per method)
        repository/<feature>_repository.dart              (abstract + Imp)
      presentation/
        <screen>_screen/
          logic/<screen>_cubit.dart + <screen>_state.dart
          ui/<screen>_screen.dart                         (thin shell: BlocListener + AppScaffold)
          ui/widgets/<screen>_body.dart + section widgets (one widget class per file)
json_data/                            mock API assets (see manifest.json)
test/                                 mirrors lib/feature; helpers/ for mocks & fixtures
```

---

## How to add a feature

Say you're adding **comments** for an article.

1. **Endpoint** — add to `core/api/api_request_helpers/end_points.dart`:
   ```dart
   static String articleComments(String articleId) => '/articles/$articleId/comments';
   ```
   Add the JSON asset under `json_data/` and a route in `core/api/mock/mock_server.dart` if the mock should serve it.

2. **Folders** — `lib/feature/comments/data/{data_source,model/params,repository}` and `lib/feature/comments/presentation/comments_screen/{logic,ui/widgets}`.

3. **Models** — `data/model/comment_model.dart`: `Equatable`, every field nullable, member order *fields → constructor → fromJson → (fromDB) → toJson → props*. Add `fromDB(CommentEntity)` only if the feature caches locally.

4. **Params** — one class per method, e.g. `data/model/params/get_comments_params.dart` with `toJson()` for API params (local-write params don't need `toJson`).

5. **Remote data source** — abstract class + `Imp` taking `ApiConsumer`. Parse with `GlobalResponse.fromJson(response.data, fromJsonT: CommentsPageModel.fromJson, withDataKey: false)`. Don't catch.

6. **Local data source (optional)** — add `core/database/tables/comments/comments_table.dart` (`@DataClassName('CommentEntity')`) and `comments_dao.dart` (every method chains `.handleLocalFailure()`), register both in `AppDatabase`, run `build_runner`. The local data source takes the DAO and maps entity ↔ model, params → companion.

7. **Repository** — abstract + `Imp`. Remote-only:
   ```dart
   if (await _network.isConnected) {
     try { return Result.success(await _remote.getComments(params)); }
     on Failure catch (e) { return Result.failure(e); }
   }
   return Result.failure(ServerFailure.noNetwork());
   ```
   Hybrid (see `FeedRepositoryImp`): fetch → cache → return; on failure/offline read the cache and return `GlobalResponse(data, isCached: true, cachedAt)`.

8. **Cubit** — `CommentsCubit(this._repository) : super(const CommentsInitialState()) { getComments(); }`. States: `CommentsInitialState`, `GetCommentsLoadingState`, `GetCommentsSuccessState`, `GetCommentsFailureState(failure)`; add a triple per extra method (`AddComment…`). Keep data on the cubit (`List<CommentModel> comments`). Controllers/scroll live on the cubit and are disposed in `close()`.

9. **UI** — `comments_screen.dart` = `BlocListener` (snackbars/navigation) around `AppScaffold(appBar: GlobalAppbar(...), body: CommentsBody())`. `CommentsBody` holds the `BlocBuilder` with an explicit `buildWhen`, switching on loading/failure/empty/success to skeleton / `AppErrorWidget` / `AppInitialStateWidget` / list. Split sections into `ui/widgets/*.dart`, one widget class per file; leaf widgets take primitives, not models.

10. **Strings** — add keys to both `assets/translations/en.json` and `ar.json`, regenerate `locale_keys.g.dart`.

11. **DI** — in `service_locator.dart` add `_commentsFeatureSetup()` (cubit factory, repository + data sources lazy singletons, DAO) and call it from `init()`.

12. **Route** — add `RoutesStrings.commentsScreen` and a `case` in `AppRouter` that wraps the screen in `BlocProvider(create: (_) => sl<CommentsCubit>(param1: articleId))`.

13. **Tests** — `test/feature/comments/data/repository/comments_repository_test.dart` (offline / success / failure branches, mocktail) and `test/feature/comments/presentation/comments_screen/logic/comments_cubit_test.dart` (use `CubitRecorder` from `test/helpers`).

---

## Features

### App nav bar

`feature/app_nav_bar` — the tab shell.

```
presentation/app_nav_bar_screen/
  logic/app_nav_tab.dart          enum: feed / search / bookmarks (icon + label key)
  logic/app_nav_bar_cubit.dart    currentTab, changeTab()
  ui/app_nav_bar_screen.dart      AppScaffold(body: AppNavBarBody, bottomNavigationBar: AppBottomNavBar)
  ui/widgets/app_nav_bar_body.dart   IndexedStack; creates FeedCubit / SearchCubit / BookmarksCubit via BlocProvider
  ui/widgets/app_bottom_nav_bar.dart, app_nav_bar_item.dart
```

`IndexedStack` keeps each tab alive, so scroll position, search query and filters survive tab switches.

### Feed

`feature/feed` — US1 discover, US2 refresh, US7 consistency, US8/US9 offline & resilience.

```
data/
  model/            TopicModel, AuthorModel, ArticleModel (feed card), FeedPageModel, FeedUpdatesModel
  model/params/     GetFeedParams (page | cursor, pageSize, topic, source), GetFeedUpdatesParams(since),
                    GetCachedFeedParams, CacheFeedPageParams
  data_source/      FeedRemoteDataSource  → GET /topics, /feed, /feed/updates
                    FeedLocalDataSource   → feed_items table + topics in CacheHelper
  repository/       FeedRepository (hybrid)
presentation/feed_screen/
  logic/feed_cubit.dart
  ui/feed_screen.dart
  ui/widgets/       feed_body, feed_topic_chips, feed_offline_banner, feed_stale_banner, feed_new_stories_pill,
                    feed_content (state switch), feed_list, feed_article_card (+ image/footer/engagement),
                    feed_skeleton_*, feed_load_more_footer, feed_app_bar_title
```

**Flow**

1. `FeedCubit` constructor: subscribes to bookmark ids, reaction updates and `onRestored`; calls `getTopics()` + `getFeed()`; starts a 30 s poll of `/feed/updates`.
2. `getFeed()` — page 1 for the selected topic. Every fetched article is overlaid with local state (`isBookmarked` from drift, pending offline reactions from the outbox). A request token discards responses from a superseded topic switch.
3. `loadMore()` — triggered by the cubit's `ScrollController` 600 px from the end. Sends `cursor` + `page`, appends with id de-duplication, guards against concurrent calls, keeps loaded pages on failure (inline retry in the footer).
4. `checkForUpdates()` — counts unseen `newItems`, remembers `deletedItems`, and shows the "New stories available" pill **without** touching the list or scroll position.
5. `refresh()` (pull-to-refresh or the pill) — calls `/feed/updates` then page 1 and **merges**: updated articles are replaced in place, unseen ones are prepended, deleted ones removed; already-loaded pages stay. If the response came from cache, the list is replaced and marked stale.
6. `toggleLike` / `toggleBookmark` — see Reactions / Bookmarks.
7. States rendered by `FeedContent`: skeleton → list; error with retry; offline empty state; empty feed. Banners above the list: offline strip (`NetworkCubit`), sync status (`SyncCubit`), stale-data banner (`isStale` + `staleSince`).

### Search

`feature/search` — US3.

```
data/
  model/            SearchResultModel, SearchPageModel, SuggestionsModel, TrendingModel(+TrendingTopicModel)
  model/params/     SearchArticlesParams (q, page, pageSize, topic, source, from, to), GetSuggestionsParams
  data_source/      SearchRemoteDataSource → GET /search, /suggest, /sources, /trending
  repository/       SearchRepository (remote only)
presentation/search_screen/
  logic/search_cubit.dart
  ui/widgets/       search_field, search_filter_bar, search_filters_sheet, search_suggestions_row,
                    search_content, search_idle_view (trending), search_results_list, search_result_tile,
                    search_highlighted_text, search_empty_view, search_load_more_footer
```

**Flow**

1. `SearchCubit` loads topics (from `FeedRepository`), sources and trending on construction.
2. `onQueryChanged(text)` — updates `query`; below 2 chars clears results; otherwise the `Debouncer` (400 ms) schedules `search()` + `getSuggestions()`.
3. `search()` — bumps the request token; a response for an older query is ignored. Results replace the list; `loadMore()` pages with id de-duplication.
4. Filters — `selectTopic` / `selectSource` / `selectDateRange` / `clearFilters` re-run the search immediately, preserving the query. Changing the topic drops a source that doesn't belong to it. The filter sheet reads the same cubit through `BlocProvider.value`.
5. Suggestions and trending chips call `applyQuery()` (immediate search, trending also sets the topic). Matched text is highlighted in the tiles.

### Article details

`feature/article` — US4, deep-link "unavailable" state.

```
data/
  model/            ArticleDetailsModel (status/reason for `unavailable`, body blocks, gallery, tags, related), ContentBlockModel
  model/params/     GetArticleParams, CacheArticleParams
  data_source/      ArticleRemoteDataSource → GET /articles/{id};  ArticleLocalDataSource → articles table
  repository/       ArticleRepository (hybrid)
presentation/article_details_screen/
  logic/article_details_cubit.dart     (registerFactoryParam: articleId)
  ui/widgets/       article_hero_header (SliverAppBar + gallery + collapsed title), article_meta_row, article_author_row,
                    article_content / article_content_block (paragraph, heading, quote, image; unknown types skipped),
                    article_tags, article_related_list/card, article_action_bar (like, comments, bookmark),
                    article_unavailable_view, article_skeleton, article_stale_banner
```

**Flow**: `getArticle()` → `GetArticleSuccessState` or `ArticleUnavailableState(reason)`; then `getRelated()` fetches the related ids in parallel (skipping failures). Bookmark and like state come from the same streams the feed uses, so the two screens never disagree. Tapping a related card pushes another details route.

### Bookmarks

`feature/bookmarks` — US5, offline-first.

```
core/database/tables/bookmarks/     BookmarkEntity: article snapshot + savedAt, isSynced, pendingRemoval
data/
  model/            BookmarkModel (fromDB), BookmarkSyncStateModel
  model/params/     AddBookmarkParams, RemoveBookmarkParams, SetBookmarkParams
  data_source/      BookmarksLocalDataSource (drift), BookmarksRemoteDataSource → PUT /bookmarks/{id}
  repository/       BookmarksRepository
presentation/bookmarks_screen/
  logic/bookmarks_cubit.dart        watches the table; removeBookmark + restoreLastRemoved (Undo)
  ui/widgets/       bookmarks_list (Dismissible rows), bookmark_tile, bookmarks_empty_view, bookmark_dismiss_background
```

**Flow**

- **Local is the source of truth.** `addBookmark` writes the row first (`isSynced=false`) and returns success; if online it then `PUT`s and marks the row synced. `removeBookmark` sets `pendingRemoval=true` (hidden from reads) and, if online, hard-deletes after the `PUT`.
- Offline or failed pushes leave rows unsynced; the **Sync** feature flushes them later. The tile shows a cloud icon while unsynced.
- `watchBookmarkedIds()` drives the bookmark icon on feed cards and the article action bar; `FeedCubit.toggleBookmark` / `ArticleDetailsCubit.toggleBookmark` flip optimistically and roll back on failure.

### Reactions

`feature/reactions` — US6, optimistic like/unlike.

```
core/database/tables/outbox/        OutboxEntity: idempotencyKey, op, articleId, payload(json), attempts
data/
  model/            ReactionResultModel (success | conflict+serverState | queued), ReactionServerStateModel,
                    ReactionUpdateModel (broadcast), PendingReactionModel (fromDB)
  model/params/     SetReactionParams (reaction, clientMutationId, expectedVersion), EnqueueReactionParams
  data_source/      ReactionsRemoteDataSource → POST /articles/{id}/reactions;  ReactionsLocalDataSource → outbox
  repository/       ReactionsRepository (+ `updates` stream)
presentation/widgets/like_button.dart      animated heart + count, used by feed card and article action bar
```

**Flow** (`FeedCubit.toggleLike`, same in `ArticleDetailsCubit`)

1. Guard: ignore if a request for this article is in flight.
2. Optimistic: flip `isLiked`, ±1 `likes`, emit.
3. `repository.setReaction(articleId, like, expectedVersion)`:
   - online → `POST` with a fresh UUID `clientMutationId` and the article's `version`;
   - offline → enqueue `set_reaction` in the outbox and return `queued`.
4. Response handling:
   - `success` → take `likes`/`version` from the server;
   - `conflict` → **server wins**: apply `serverState` (isLiked/likes/version);
   - `queued` → keep the optimistic state, snackbar "we'll sync later";
   - failure → **roll back** to the previous article, error snackbar.
5. Confirmed state is published on `ReactionsRepository.updates` so the other screen patches its copy. Pending outbox reactions are overlaid on cached/fresh articles so an offline like survives a restart.

### Sync (offline outbox)

`feature/sync` — bonus, app-wide.

```
data/
  model/            SyncMutationModel, SyncResultModel, SyncConflictModel;  params/SyncParams
  data_source/      SyncRemoteDataSource → POST /sync;  SyncLocalDataSource → outbox + baseVersion (CacheHelper)
  repository/       SyncRepository
presentation/
  logic/sync_cubit.dart              lazy singleton provided in MyApp
  widgets/sync_status_banner.dart    shown under the feed's offline strip
```

**Flow**

1. `SyncCubit` runs `sync()` on start and whenever `NetworkCubit.onRestored` fires; one run at a time; failed runs retry after 30 s while online.
2. `SyncRepository.sync()` collects pending work — outbox `set_reaction` rows plus bookmark rows that are unsynced or pending removal (turned into `set_bookmark` mutations with deterministic keys `bookmark:<id>:<savedAt>` / `unbookmark:<id>:<savedAt>`) — and sends **one** `POST /sync { baseVersion, mutations }`.
3. Applying the response:
   - `applied` → outbox rows deleted; bookmarks marked synced / hard-deleted;
   - `conflicts` → the local mutation is dropped and, for reactions, the server state is broadcast so hearts reconcile;
   - `newVersion` persisted as the next `baseVersion`;
   - failure or offline → nothing is touched, everything stays queued.
4. Banner: "Syncing N changes…" → "All changes synced" / "N changes were reverted to match the server" / "Sync failed — will retry", then hides.

### Offline cache

Cross-cutting (US8/US9), implemented inside Feed and Article.

```
core/database/tables/feed_items/    (articleId, feedTopicId) PK, feedPosition, full card snapshot, cachedAt
core/database/tables/articles/      full details with body/gallery/tags/related as JSON, cachedAt
```

- **Online**: every fetched feed page is written to `feed_items` (page 1 replaces that topic's set, later pages upsert); every opened article is written to `articles` (kept to the newest 150). Topics are cached in `CacheHelper`.
- **Offline or remote failure**: page 1 is served from `feed_items` for the selected topic, wrapped in `GlobalResponse(isCached: true, cachedAt)`; `nextCursor` is null so there's no phantom pagination; an opened article is served from `articles`; a cache miss returns the original failure.
- `/feed/updates` deletions and `unavailable` articles evict cache rows.
- The cubits expose `isStale`/`staleSince`; the amber stale banner says how old the copy is and offers retry. When connectivity returns, the feed refreshes itself and the banner clears.
- Images are cached on disk by `cached_network_image`, so cached cards keep their photos.

---

## Mock API

`core/api/mock/` is a full in-process server, selected by `EnvironmentKeys.useMockApi` (default `true`).

- `MockApiConsumer` implements `ApiConsumer`; data sources don't know they're talking to a mock.
- `MockServer` routes method + path to handlers for every endpoint in the task (`/topics`, `/sources`, `/feed` with page/cursor/topic/source, `/feed/updates`, `/articles/{id}`, `/articles/{id}/reactions`, `/search`, `/suggest`, `/bookmarks`, `/sync`, `/flags`, `/trending`). Errors are thrown as `DioException`s so the real error mapping is exercised.
- `MockStore` holds in-memory state loaded from `json_data/`: likes/versions mutate, reactions are idempotent on `clientMutationId`, `expectedVersion` mismatches return `conflict`, `/sync` applies mutations and reports `review_required` for conflicts.
- The first `/feed/updates` call "releases" two new stories, bumps one article's version and deletes `a_removed_story` — that's what drives the "New stories available" pill, the conflict demo and the unavailable-article state.
- `MockServerConfig` (`sl<MockServer>().config`) lets you set latency, a random `failureRate`, `failNextRequest`, or `alwaysFailPaths` to demo error and rollback states.

`json_data/manifest.json` maps every endpoint to its asset file.

---

## Local database

One `AppDatabase` (`core/database/app_database.dart`, schema v1) with four tables: `bookmarks`, `outbox_mutations`, `feed_items`, `articles`. Layering is strictly `DAO → LocalDataSource → Repository → Cubit`; DAOs wrap every call in `handleLocalFailure()` so sqlite errors surface as `LocalFailure`. Schema changes bump `schemaVersion` and add an `onUpgrade` step.

---

## Tests

```bash
flutter test
```

48 tests, mirroring `lib/feature` under `test/feature`, with shared helpers in `test/helpers` (mocktail mocks, fixtures, a `CubitRecorder` for state sequences, `pumpApp` for widget tests with real translations and theme). `test/flutter_test_config.dart` silences the logger.

| Area (task requirement) | Where |
|---|---|
| Feed pagination — append, de-dup, in-flight guard, failure keeps pages, refresh merge, new-stories count, stale flags | `feed/presentation/.../feed_cubit_test.dart` |
| Search debounce — 400 ms coalescing (`fakeAsync`), min length, clear, stale-response discard, filters preserved | `search/presentation/.../search_cubit_test.dart` |
| Bookmark persistence — real in-memory drift: add/sync/offline/failed push, remove online/offline, id stream | `bookmarks/data/repository/bookmarks_repository_test.dart` |
| Optimistic reaction rollback — optimistic flip, confirm, **rollback on failure**, conflict reconcile, duplicate tap, queued offline | `feed_cubit_test.dart` + `reactions/data/repository/reactions_repository_test.dart` |
| Widget test — skeleton → cards; error → Retry → cards | `feed/presentation/.../ui/feed_screen_test.dart` |
| Accessibility — semantics labels/toggle state on cards, `androidTapTargetGuideline` + `labeledTapTargetGuideline`, feed states at 1.5× text scale | `feed/presentation/.../ui/feed_screen_test.dart` (`accessibility` group) |
| Cache fallback branches, sync batching/conflicts/failure | `feed_repository_test.dart`, `sync_repository_test.dart` |

`bloc_test` isn't used because it pins `analyzer` to a range incompatible with `drift_dev`; `CubitRecorder` covers the same assertions.

---

## Accessibility

- Every tappable control is a labelled semantics button with a ≥48pt hit area (visuals stay at 40pt where the design wants them; the extra area is transparent padding inside the ink). Toggles (like, bookmark, theme options, chips) expose `toggled`/`selected` state, and counts read as "29 comments" rather than a bare number.
- Cards (feed, search, bookmarks, related) expose one label — title, source, topic, author, time — with an "Open article" hint; their inner texts are excluded so screen readers don't read the card twice.
- Offline, stale, sync and "New stories available" banners are live regions, so a screen reader announces them when they appear.
- Images are decorative by default (`AppNetworkImage` excludes them); article body and gallery images carry their caption or an "Article image n/m" label.
- Text uses `AppTextStyle` sizes that honour the platform text scaler; the widget test pumps the feed at 1.5× and asserts no overflow. Colors come from the skins, which keep body text ≥ 4.5:1 on their surfaces in both themes.


# Flutter Take-Home Task
## News Feed App

> A focused assignment to assess architecture, state management, pagination, search, offline strategy, optimistic updates, and overall reasoning.

Congratulations! You've successfully passed the first interview, and we're excited to let you know that you've moved forward in the hiring process. This reflects the strong skills, attitude, and potential we see in you as a future team member.

Your next challenge is the **Flutter Take-Home Task - News Feed App**. This task is an opportunity to demonstrate your Flutter expertise, problem-solving, product thinking, and ability to build a resilient mobile experience. It is not only about writing code; it is about showing how you structure an application, manage changing data, handle offline behavior, and make thoughtful engineering choices.

Plan your approach, focus on the core experience, and give it your best effort. We look forward to seeing your take.

Best of luck with this next step - we're rooting for you!

---

## 1) Scenario — What to Build

Create **News Feed**, a mobile app where users can:

- Browse a personalized, paginated feed containing articles from multiple topics and publishers.
- Search articles using debounced input and filter results by topic, source, or date.
- Open article details, bookmark stories, and react to content.
- Refresh the feed and receive newly published items without duplicating existing content.
- Continue using the app offline with clear, honest UX and synchronized actions after reconnection.

No real backend is required. Serve JSON locally or through a mock service. The goal is the application's architecture and behavior, not hosting.

## 2) Core User Stories

| ID | User Story |
|---|---|
| **US1 - Discover** | View a paginated feed with headline, image, source, topic, publish time, and engagement counts. |
| **US2 - Refresh** | Pull to refresh and prepend new articles without duplicates or losing the current feed state. |
| **US3 - Search** | Search headlines and summaries using debounced input; filter by topic and source. |
| **US4 - Article Details** | View the full article, author, image gallery, tags, and related stories. |
| **US5 - Bookmark** | Save or remove articles and access bookmarks offline across app sessions. |
| **US6 - Reactions** | Like or unlike an article using an optimistic UI; revert safely when the request fails. |
| **US7 - Feed Consistency** | Handle updated or deleted articles during refresh and synchronization. |
| **US8 - Offline Mode** | Browse the last cached feed and article details, manage bookmarks, and queue reactions for later synchronization. |
| **US9 - Resilience** | Provide distinct loading, empty, error, stale-data, and retry experiences. |

## 3) Mock Data and Endpoints Shape (Not Strict API)

Use any or all of the following as JSON assets. You may extend the data where useful.

### 3.1 GET `/TOPICS`

```json
[
  {"id":"t_technology","name":"Technology","icon":"devices"},
  {"id":"t_business","name":"Business","icon":"business"},
  {"id":"t_sports","name":"Sports","icon":"sports_soccer"},
  {"id":"t_science","name":"Science","icon":"science"},
  {"id":"t_health","name":"Health","icon":"health_and_safety"},
  {"id":"t_culture","name":"Culture","icon":"palette"}
]
```

### 3.2 GET `/SOURCES?TOPICID={ID}`

```json
{
  "t_technology": ["TechWire", "Future Stack", "Mobile Daily"],
  "t_business": ["Market Brief", "Global Ledger", "Startup Post"],
  "t_sports": ["Match Point", "Arena News", "The Final Whistle"]
}
```

### 3.3 GET `/FEED?PAGE=1&PAGESIZE=10&TOPIC=&SOURCE=`

```json
{
  "data": [
    {
      "id":"a_flutter_roadmap",
      "title":"Flutter Team Shares the Next Performance Roadmap",
      "summary":"New rendering and tooling work targets smoother apps.",
      "source":"Mobile Daily",
      "author":{"id":"u_maya","name":"Maya Chen","avatar":"https://picsum.photos/seed/maya/120"},
      "topicId":"t_technology",
      "publishedAt":"2026-09-14T08:30:00Z",
      "image":"https://picsum.photos/seed/flutter-news/900/600",
      "tags":["flutter","mobile"],
      "likes":184,
      "comments":29,
      "isLiked":false,
      "isBookmarked":true
    },
    {
      "id":"a_clean_energy",
      "title":"Battery Breakthrough Improves Grid Storage Efficiency",
      "summary":"Researchers report longer cycle life in early trials.",
      "source":"Science Journal",
      "author":{"id":"u_omar","name":"Omar Hassan","avatar":"https://picsum.photos/seed/omar/120"},
      "topicId":"t_science",
      "publishedAt":"2026-09-14T06:10:00Z",
      "image":"https://picsum.photos/seed/energy/900/600",
      "tags":["energy","research"],
      "likes":96,
      "comments":11,
      "isLiked":true,
      "isBookmarked":false
    }
  ],
  "page":1,
  "pageSize":10,
  "total":86,
  "nextCursor":"feed_2"
}
```

### 3.3.1 GET `/FEED?CURSOR=FEED_2`

```json
{
  "data": [
    {
      "id":"a_market_week",
      "title":"Markets Open Higher as Technology Shares Advance",
      "summary":"Investors watch inflation data and earnings guidance.",
      "source":"Market Brief",
      "author":{"id":"u_lina","name":"Lina Adel"},
      "topicId":"t_business",
      "publishedAt":"2026-09-13T19:45:00Z",
      "image":"https://picsum.photos/seed/market/900/600",
      "tags":["markets"],
      "likes":51,
      "comments":8,
      "isLiked":false,
      "isBookmarked":false
    }
  ],
  "page":2,
  "pageSize":10,
  "total":86,
  "nextCursor":"feed_3"
}
```

### 3.4 GET `/ARTICLES/{ID}`

```json
{
  "id":"a_flutter_roadmap",
  "title":"Flutter Team Shares the Next Performance Roadmap",
  "summary":"New rendering and tooling work targets smoother apps.",
  "body":[
    {"type":"paragraph","text":"The roadmap focuses on startup time..."},
    {"type":"image","url":"https://picsum.photos/seed/rendering/900/500"},
    {"type":"quote","text":"Performance is a product feature."}
  ],
  "source":"Mobile Daily",
  "author":{"id":"u_maya","name":"Maya Chen","bio":"Mobile technology editor."},
  "topicId":"t_technology",
  "publishedAt":"2026-09-14T08:30:00Z",
  "updatedAt":"2026-09-14T09:12:00Z",
  "readTimeMinutes":5,
  "tags":["flutter","mobile"],
  "related":["a_architecture_patterns","a_dart_tooling"],
  "likes":184,
  "comments":29,
  "isLiked":false,
  "isBookmarked":true
}
```

### 3.4.1 GET `/ARTICLES/{ID}` — Article Updated

```json
{
  "status":"updated",
  "articleId":"a_flutter_roadmap",
  "version":4,
  "updatedAt":"2026-09-14T09:12:00Z"
}
```

### 3.4.2 GET `/ARTICLES/{ID}` — Article Unavailable

```json
{
  "status":"unavailable",
  "articleId":"a_removed_story",
  "reason":"removed_by_publisher"
}
```

### 3.5 GET `/SEARCH?Q=FLUTTER&PAGE=1&PAGESIZE=10&TOPIC=`

```json
{
  "query":"flutter",
  "data":[
    {
      "id":"a_flutter_roadmap",
      "title":"Flutter Team Shares the Next Performance Roadmap",
      "summary":"New rendering and tooling work targets smoother apps.",
      "source":"Mobile Daily",
      "topicId":"t_technology",
      "publishedAt":"2026-09-14T08:30:00Z",
      "image":"https://picsum.photos/seed/flutter-news/900/600"
    }
  ],
  "page":1,
  "pageSize":10,
  "total":14
}
```

### 3.5.1 GET `/SUGGEST?Q=FLU`

```json
{
  "q":"flu",
  "suggestions":["flutter","flutter performance","flutter architecture"]
}
```

### 3.6 POST `/ARTICLES/{ID}/REACTIONS` — Request

```json
{
  "reaction":"like",
  "clientMutationId":"uuid-101",
  "expectedVersion":3
}
```

### 3.6.1 POST `/ARTICLES/{ID}/REACTIONS` — Success

```json
{
  "status":"success",
  "articleId":"a_flutter_roadmap",
  "reaction":"like",
  "likes":185,
  "version":4
}
```

### 3.6.2 POST `/ARTICLES/{ID}/REACTIONS` — Conflict

```json
{
  "status":"conflict",
  "articleId":"a_flutter_roadmap",
  "serverState":{"isLiked":true,"likes":186,"version":5}
}
```

### 3.6.3 POST `/ARTICLES/{ID}/REACTIONS` — Failure

```json
{
  "status":"error",
  "code":"TEMPORARY_FAILURE",
  "message":"Reaction was not saved. Please retry."
}
```

### 3.7 PUT `/BOOKMARKS/{ARTICLEID}`

```json
{
  "bookmarked":true,
  "updatedAt":"2026-09-14T10:02:00Z"
}
```

### 3.7.1 GET `/BOOKMARKS`

```json
{
  "data":["a_flutter_roadmap","a_market_week"],
  "version":12
}
```

### 3.8 GET `/FEED/UPDATES?SINCE={TIMESTAMP}`

```json
{
  "newItems":["a_ai_policy"],
  "updatedItems":["a_flutter_roadmap"],
  "deletedItems":["a_removed_story"],
  "serverTime":"2026-09-14T10:15:00Z"
}
```

### 3.9 POST `/SYNC` — Offline Outbox Demo

**Request:**

```json
{
  "baseVersion":18,
  "mutations":[
    {
      "op":"set_reaction",
      "idempotencyKey":"uuid-101",
      "payload":{"articleId":"a_flutter_roadmap","reaction":"like"}
    },
    {
      "op":"set_bookmark",
      "idempotencyKey":"uuid-102",
      "payload":{"articleId":"a_market_week","bookmarked":true}
    }
  ]
}
```

**Response:**

```json
{
  "status":"review_required",
  "newVersion":19,
  "applied":["uuid-102"],
  "conflicts":[
    {"idempotencyKey":"uuid-101","serverLikes":186,"isLiked":true}
  ]
}
```

### 3.10 GET `/FLAGS`

```json
{
  "enableReactions":true,
  "enableBookmarks":true,
  "enableOfflineOutbox":true,
  "searchDebounceMs":400,
  "feedPageSize":10,
  "cacheTtlMinutes":30,
  "showTrendingTopics":true,
  "maintenanceMode":false
}
```

### 3.11 GET `/TRENDING`

```json
{
  "date":"2026-09-14",
  "topics":[
    {"label":"Flutter","articleCount":18},
    {"label":"Clean Energy","articleCount":12},
    {"label":"Markets","articleCount":9}
  ]
}
```

## 4) Functional Requirements

- **Architecture:** Use clear data, domain, and presentation layers. Keep repositories behind interfaces and make dependencies injection-friendly.
- **State Management:** Use BLoC.
- **Feed Pagination:** Implement infinite scroll with page-level loading, deduplication, and retry.
- **Refresh:** Pull to refresh, prepend new items, and reconcile updated or deleted articles.
- **Search:** Debounce input, cancel or ignore stale requests, and preserve active filters.
- **Article Details:** Render content blocks safely and expose related stories.
- **Bookmarks:** Add and remove bookmarks, provide a dedicated list, and persist it locally.
- **Optimistic Reactions:** Update like state immediately, prevent duplicate submissions, then confirm, reconcile, or roll back based on the response.
- **Offline Mode:** Cache feed pages and article details, show a visible offline or stale-data banner, and permit bookmark and reaction actions offline.
- **Synchronization:** Queue offline mutations with idempotency keys and process them safely after reconnection.
- **Error / Empty / Loading:** Use distinct states with friendly messages, skeletons where useful, and safe retry actions.
- **Theming:** Support light and dark themes and follow the system setting.

## 5) Non-Functional Requirements

- **Performance:** Reduce unnecessary rebuilds and main-thread work; use lazy loading, efficient lists, and sensible image and data caching.
- **Code Quality:** Keep the code clean, readable, scalable, testable, and maintainable.
- **SOLID and Design Patterns:** Apply them only when they improve clarity and maintainability; avoid unnecessary complexity.
- **Testing:** Include unit tests for feed pagination, search debounce, bookmark persistence, and optimistic reaction rollback. Add at least one widget test for a primary state transition.
- **Accessibility:** Provide useful semantics, readable contrast, scalable text behavior, and keyboard or screen-reader-friendly actions where applicable.
- **Documentation:** Provide a concise `README.md` describing architecture, setup, features, tradeoffs, and offline synchronization behavior.

## 6) Bonus

- **Offline outbox:** Allow reactions and bookmarks while offline, then synchronize them safely when connectivity returns.
- **Live update simulation:** Surface a `New stories available` prompt without unexpectedly changing the user's scroll position.
- **Deep links:** Open a specific article from a link and provide a graceful unavailable state.
- **Accessibility test coverage or golden tests** for the main feed states.

## 7) Submission Checklist

- Git repository with `/lib` organized into clear layers.
- Mock JSON assets or a documented mock service, including `pubspec.yaml` entries where applicable.
- `README.md` with setup steps, architecture decisions, completed scope, tradeoffs, and known limitations.
- Automated tests that cover the required business logic.
- Short screen recording of **no more than two minutes** showing:
  - Feed pagination
  - Pull to refresh
  - Debounced search
  - Article details
  - Bookmark persistence
  - Optimistic like handling
  - Offline behavior

## 8) What We Are Looking For

- **Separation of Concerns:** Clear boundaries and independently testable business logic.
- **Feed Correctness:** Reliable pagination, request ordering, deduplication, refresh, and conflict handling.
- **Offline Reliability:** Honest offline UX, durable local state, and predictable synchronization.
- **User Experience:** Smooth scrolling, useful feedback, accessible controls, and polished edge states.
- **Extensible Codebase:** A structure that another developer can understand and enhance safely.
- **Engineering Judgment:** Sensible scope, clearly explained tradeoffs, and complexity that serves the product.

## 9) Deadline

The deadline is **3 days from the date you receive the task**.

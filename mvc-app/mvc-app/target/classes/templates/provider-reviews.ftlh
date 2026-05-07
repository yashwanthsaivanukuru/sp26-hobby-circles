<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Manage Reviews – HobbyCircles</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --forest: #1a3a2a; --forest-mid: #2c5f3f; --forest-light: #3d7a54;
      --cream: #f7f2ea; --cream-dark: #ede5d4; --gold: #c9a84c;
      --text-dark: #1a1a1a; --text-mid: #4a4a4a; --text-light: #888;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); display: flex; min-height: 100vh; }

    .sidebar { width: 240px; background: var(--forest); min-height: 100vh; display: flex; flex-direction: column; position: fixed; top: 0; left: 0; padding: 32px 0; }
    .sidebar-logo { font-family: 'Playfair Display', serif; font-size: 1.3rem; color: var(--cream); padding: 0 24px 32px; border-bottom: 1px solid rgba(255,255,255,0.08); margin-bottom: 16px; }
    .sidebar-logo span { color: var(--gold); }
    .sidebar-badge { padding: 0 24px 24px; border-bottom: 1px solid rgba(255,255,255,0.08); margin-bottom: 16px; }
    .sidebar-badge .role { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--gold); font-weight: 600; margin-bottom: 4px; }
    .sidebar-badge .email { font-size: 0.82rem; color: rgba(247,242,234,0.6); word-break: break-all; }
    .sidebar-nav { flex: 1; padding: 0 12px; display: flex; flex-direction: column; gap: 2px; }
    .sidebar-link { display: flex; align-items: center; gap: 10px; padding: 11px 14px; border-radius: 10px; color: rgba(247,242,234,0.6); text-decoration: none; font-size: 0.875rem; font-weight: 500; transition: all 0.2s; }
    .sidebar-link:hover { background: rgba(255,255,255,0.07); color: var(--cream); }
    .sidebar-link.active { background: var(--gold); color: var(--forest); font-weight: 600; }
    .sidebar-link .icon { font-size: 1rem; width: 20px; text-align: center; }
    .sidebar-bottom { padding: 16px 12px 0; border-top: 1px solid rgba(255,255,255,0.08); margin-top: auto; }

    .main { margin-left: 240px; flex: 1; padding: 48px; }

    .page-header { margin-bottom: 32px; }
    .page-header h1 { font-family: 'Playfair Display', serif; font-size: 2rem; color: var(--forest); margin-bottom: 6px; }
    .page-header p { color: var(--text-light); font-size: 0.9rem; }

    /* Rating summary bar */
    .rating-summary {
      background: linear-gradient(135deg, var(--forest-mid), var(--forest));
      border-radius: 16px; padding: 28px 32px;
      display: flex; align-items: center; gap: 32px;
      margin-bottom: 32px; color: var(--cream);
    }
    .rating-big { font-family: 'Playfair Display', serif; font-size: 3.5rem; line-height: 1; }
    .rating-stars { font-size: 1.3rem; color: var(--gold); margin-bottom: 4px; }
    .rating-sub { font-size: 0.8rem; color: rgba(247,242,234,0.55); }

    .reviews-list { display: flex; flex-direction: column; gap: 20px; }

    .review-card {
      background: white; border-radius: 16px; padding: 28px 32px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.04);
      animation: fadeUp 0.4s ease both;
    }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

    .review-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 14px; }
    .stars { color: var(--gold); font-size: 1.1rem; letter-spacing: 2px; }
    .rating-label { font-size: 0.8rem; color: var(--text-light); margin-left: 8px; }
    .review-id { font-size: 0.75rem; color: var(--text-light); font-family: monospace; }

    .review-comment {
      font-size: 0.95rem; color: var(--text-mid); line-height: 1.6;
      font-style: italic; margin-bottom: 20px;
      padding-left: 16px; border-left: 3px solid var(--cream-dark);
    }

    .existing-reply {
      background: rgba(61,122,84,0.06); border-radius: 10px;
      padding: 14px 16px; margin-bottom: 16px;
      border-left: 3px solid var(--forest-light);
    }
    .existing-reply .label { font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.06em; color: var(--forest-light); margin-bottom: 6px; }
    .existing-reply p { font-size: 0.875rem; color: var(--text-mid); line-height: 1.5; }

    .reply-form label { display: block; font-size: 0.75rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.06em; color: var(--text-mid); margin-bottom: 8px; }
    .reply-form textarea {
      width: 100%; padding: 12px 14px; border: 1.5px solid #e0e0e0; border-radius: 10px;
      font-size: 0.875rem; font-family: 'DM Sans', sans-serif; color: var(--text-dark);
      resize: vertical; min-height: 80px; transition: border-color 0.2s, box-shadow 0.2s;
    }
    .reply-form textarea:focus { outline: none; border-color: var(--forest-light); box-shadow: 0 0 0 3px rgba(61,122,84,0.1); }
    .btn-reply {
      margin-top: 10px; padding: 9px 20px; background: var(--forest); color: var(--cream);
      border: none; border-radius: 8px; font-size: 0.85rem; font-weight: 600;
      cursor: pointer; font-family: 'DM Sans', sans-serif; transition: background 0.2s;
    }
    .btn-reply:hover { background: var(--forest-mid); }

    .empty-state {
      background: white; border-radius: 16px; padding: 72px 24px;
      text-align: center; box-shadow: 0 2px 12px rgba(0,0,0,0.05);
      border: 2px dashed var(--cream-dark);
    }
    .empty-state .icon { font-size: 3rem; margin-bottom: 16px; }
    .empty-state h3 { color: var(--text-mid); margin-bottom: 8px; }
    .empty-state p { color: var(--text-light); font-size: 0.875rem; }

    .no-circle-alert {
      background: #fff8e8; border-left: 4px solid var(--gold);
      border-radius: 10px; padding: 16px 20px;
      font-size: 0.9rem; color: #7a5c00; margin-bottom: 24px;
    }
    .no-circle-alert a { color: var(--forest); font-weight: 600; }
  </style>
</head>
<body>
<aside class="sidebar">
  <div class="sidebar-logo">Hobby<span>Circles</span></div>
  <div class="sidebar-badge">
    <div class="role">✦ Provider</div>
    <div class="email">${provider.email!''}</div>
  </div>
  <nav class="sidebar-nav">
    <a href="/providers/${provider.userId?c}" class="sidebar-link"><span class="icon">🏠</span> Dashboard</a>
    <a href="/providers/${provider.userId?c}/circle" class="sidebar-link"><span class="icon">⚙️</span> My Circle</a>
    <a href="/providers/${provider.userId?c}/reviews" class="sidebar-link active"><span class="icon">⭐</span> Reviews</a>
    <a href="/providers/${provider.userId?c}/statistics" class="sidebar-link"><span class="icon">📊</span> Statistics</a>
    <a href="/providers/${provider.userId?c}/events" class="sidebar-link"><span class="icon">📅</span> Events</a>
  </nav>
  <div class="sidebar-bottom">
    <a href="/auth/logout" class="sidebar-link"><span class="icon">↩</span> Sign Out</a>
  </div>
</aside>

<main class="main">
  <div class="page-header">
    <h1>Manage Reviews</h1>
    <p>Read feedback from your members and respond to reviews</p>
  </div>

  <#if circle??>
    <div class="rating-summary">
      <div>
        <div class="rating-big">${avgRating}</div>
        <div class="rating-sub">out of 5</div>
      </div>
      <div>
        <div class="rating-stars">
          <#list 1..5 as i>
            <#if i <= avgRating?number>★<#else>☆</#if>
          </#list>
        </div>
        <div style="font-size:0.95rem; font-weight:600;">${circle.name}</div>
        <div class="rating-sub">${reviews?size} review<#if (reviews?size != 1)>s</#if></div>
      </div>
    </div>
  <#else>
    <div class="no-circle-alert">
      You haven't created a circle yet. <a href="/providers/${provider.userId?c}/circle">Create one first →</a>
    </div>
  </#if>

  <div class="reviews-list">
    <#if reviews?has_content>
      <#list reviews as review>
        <div class="review-card" style="animation-delay:${review?index * 0.05}s">
          <div class="review-header">
            <div>
              <span class="stars">
                <#list 1..5 as i><#if i <= review.rating>★<#else>☆</#if></#list>
              </span>
              <span class="rating-label">${review.rating} / 5</span>
            </div>
            <span class="review-id">#REV-${review.reviewId?c}</span>
          </div>

          <p class="review-comment">"${review.comment!''}"</p>

          <#if review.replyText?has_content>
            <div class="existing-reply">
              <div class="label">Your Reply</div>
              <p>${review.replyText}</p>
            </div>
          </#if>

          <div class="reply-form">
            <form action="/providers/${provider.userId?c}/reviews/${review.reviewId?c}/reply" method="post">
              <label><#if review.replyText?has_content>Update Reply<#else>Write a Reply</#if></label>
              <textarea name="replyText" placeholder="Write your response to this review...">${review.replyText!''}</textarea>
              <button type="submit" class="btn-reply">Submit Reply →</button>
            </form>
          </div>
        </div>
      </#list>
    <#else>
      <div class="empty-state">
        <div class="icon">⭐</div>
        <h3>No reviews yet</h3>
        <p>Reviews will appear here once members submit them.</p>
      </div>
    </#if>
  </div>
</main>
</body>
</html>

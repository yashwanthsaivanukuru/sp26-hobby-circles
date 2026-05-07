<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Statistics – HobbyCircles</title>
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

    .page-header { margin-bottom: 40px; }
    .page-header h1 { font-family: 'Playfair Display', serif; font-size: 2rem; color: var(--forest); margin-bottom: 6px; }
    .page-header p { color: var(--text-light); font-size: 0.9rem; }

    /* Stats grid */
    .stats-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-bottom: 32px; }

    .stat-card {
      background: white; border-radius: 16px; padding: 32px 28px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.04);
      position: relative; overflow: hidden;
      animation: fadeUp 0.4s ease both;
    }
    .stat-card::before {
      content: attr(data-icon);
      position: absolute; top: 16px; right: 20px;
      font-size: 2rem; opacity: 0.15;
    }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

    .stat-card .label { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.08em; color: var(--text-light); font-weight: 600; margin-bottom: 10px; }
    .stat-card .value { font-family: 'Playfair Display', serif; font-size: 3rem; color: var(--forest); line-height: 1; margin-bottom: 6px; }
    .stat-card .sub { font-size: 0.8rem; color: var(--text-light); }

    /* Featured stat */
    .stat-card.featured {
      background: linear-gradient(135deg, var(--forest-mid), var(--forest));
      color: var(--cream);
    }
    .stat-card.featured .label { color: rgba(247,242,234,0.55); }
    .stat-card.featured .value { color: var(--gold); }
    .stat-card.featured .sub { color: rgba(247,242,234,0.5); }

    /* Circle info card */
    .info-card {
      background: white; border-radius: 16px; padding: 32px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.04);
      animation: fadeUp 0.4s ease 0.15s both;
    }
    .info-card h2 { font-family: 'Playfair Display', serif; font-size: 1.2rem; color: var(--forest); margin-bottom: 20px; }
    .info-row { display: flex; justify-content: space-between; align-items: center; padding: 12px 0; border-bottom: 1px solid var(--cream-dark); }
    .info-row:last-child { border-bottom: none; }
    .info-row .key { font-size: 0.8rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.06em; color: var(--text-light); }
    .info-row .val { font-size: 0.9rem; color: var(--text-dark); font-weight: 500; }

    .no-circle-alert {
      background: white; border-radius: 16px; padding: 72px 24px;
      text-align: center; box-shadow: 0 2px 12px rgba(0,0,0,0.05);
      border: 2px dashed var(--cream-dark);
    }
    .no-circle-alert .icon { font-size: 3rem; margin-bottom: 16px; }
    .no-circle-alert h3 { color: var(--text-mid); margin-bottom: 8px; }
    .no-circle-alert p { color: var(--text-light); font-size: 0.875rem; margin-bottom: 20px; }
    .btn-create { display: inline-block; padding: 11px 24px; background: var(--forest); color: var(--cream); border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.875rem; }
    .btn-create:hover { background: var(--forest-mid); }
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
    <a href="/providers/${provider.userId?c}/reviews" class="sidebar-link"><span class="icon">⭐</span> Reviews</a>
    <a href="/providers/${provider.userId?c}/statistics" class="sidebar-link active"><span class="icon">📊</span> Statistics</a>
    <a href="/providers/${provider.userId?c}/events" class="sidebar-link"><span class="icon">📅</span> Events</a>
  </nav>
  <div class="sidebar-bottom">
    <a href="/auth/logout" class="sidebar-link"><span class="icon">↩</span> Sign Out</a>
  </div>
</aside>

<main class="main">
  <div class="page-header">
    <h1>Statistics</h1>
    <#if circle??>
      <p>Overview for <strong>${circle.name}</strong></p>
    </#if>
  </div>

  <#if circle??>
    <div class="stats-grid">
      <div class="stat-card featured" data-icon="👥" style="animation-delay:0s">
        <div class="label">Total Memberships</div>
        <div class="value">${memberCount}</div>
        <div class="sub">active members</div>
      </div>
      <div class="stat-card" data-icon="📅" style="animation-delay:0.05s">
        <div class="label">Events Scheduled</div>
        <div class="value">${upcomingCount}</div>
        <div class="sub">upcoming meetups</div>
      </div>
      <div class="stat-card" data-icon="⭐" style="animation-delay:0.1s">
        <div class="label">Average Rating</div>
        <div class="value">${avgRating}</div>
        <div class="sub">out of 5 stars</div>
      </div>
      <div class="stat-card" data-icon="💬" style="animation-delay:0.15s">
        <div class="label">Total Reviews</div>
        <div class="value">${reviewCount}</div>
        <div class="sub">member reviews</div>
      </div>
    </div>

    <div class="info-card">
      <h2>Circle Details</h2>
      <div class="info-row">
        <span class="key">Category</span>
        <span class="val">${circle.category!''}</span>
      </div>
      <div class="info-row">
        <span class="key">City</span>
        <span class="val">${circle.city!''}</span>
      </div>
      <div class="info-row">
        <span class="key">Created</span>
        <span class="val">${circle.createdAt}</span>
      </div>
      <div class="info-row">
        <span class="key">Last Updated</span>
        <span class="val">${circle.updatedAt}</span>
      </div>
    </div>
  <#else>
    <div class="no-circle-alert">
      <div class="icon">📊</div>
      <h3>No data yet</h3>
      <p>Create your circle first to start seeing statistics.</p>
      <a href="/providers/${provider.userId?c}/circle" class="btn-create">Create Your Circle →</a>
    </div>
  </#if>
</main>
</body>
</html>

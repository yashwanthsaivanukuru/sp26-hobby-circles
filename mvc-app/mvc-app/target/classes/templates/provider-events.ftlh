<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Events – HobbyCircles</title>
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
    .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 32px; flex-wrap: wrap; gap: 16px; }
    .page-header h1 { font-family: 'Playfair Display', serif; font-size: 2rem; color: var(--forest); }
    .page-header p { color: var(--text-light); font-size: 0.9rem; margin-top: 4px; }

    .btn-new {
      padding: 11px 22px; background: var(--forest); color: var(--cream);
      border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.875rem;
      transition: background 0.2s, transform 0.1s; white-space: nowrap;
    }
    .btn-new:hover { background: var(--forest-mid); transform: translateY(-1px); }

    .events-list { display: flex; flex-direction: column; gap: 16px; }

    .event-card {
      background: white; border-radius: 16px; padding: 28px 32px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.04);
      display: flex; gap: 24px; align-items: flex-start;
      animation: fadeUp 0.4s ease both;
      transition: transform 0.2s, box-shadow 0.2s;
    }
    .event-card:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,0.09); }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

    .event-date-block {
      background: linear-gradient(135deg, var(--forest-mid), var(--forest));
      color: var(--cream); border-radius: 12px; padding: 14px 16px;
      text-align: center; min-width: 64px; flex-shrink: 0;
    }
    .event-date-block .day { font-family: 'Playfair Display', serif; font-size: 1.6rem; line-height: 1; }
    .event-date-block .month { font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.08em; color: rgba(247,242,234,0.7); margin-top: 2px; }

    .event-info { flex: 1; }
    .event-info h3 { font-size: 1.05rem; font-weight: 600; color: var(--text-dark); margin-bottom: 8px; }
    .event-meta { display: flex; gap: 16px; flex-wrap: wrap; margin-bottom: 10px; }
    .event-meta-item { display: flex; align-items: center; gap: 5px; font-size: 0.8rem; color: var(--text-light); }
    .event-info p { font-size: 0.875rem; color: var(--text-mid); line-height: 1.5; }

    .status-badge {
      display: inline-flex; align-items: center; gap: 5px;
      padding: 3px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600;
      background: rgba(39,174,96,0.1); color: #27ae60;
    }

    .empty-state {
      background: white; border-radius: 16px; padding: 72px 24px;
      text-align: center; box-shadow: 0 2px 12px rgba(0,0,0,0.05);
      border: 2px dashed var(--cream-dark);
    }
    .empty-state .icon { font-size: 3rem; margin-bottom: 16px; }
    .empty-state h3 { color: var(--text-mid); margin-bottom: 8px; }
    .empty-state p { color: var(--text-light); font-size: 0.875rem; }
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
    <a href="/providers/${provider.userId?c}/statistics" class="sidebar-link"><span class="icon">📊</span> Statistics</a>
    <a href="/providers/${provider.userId?c}/events" class="sidebar-link active"><span class="icon">📅</span> Events</a>
  </nav>
  <div class="sidebar-bottom">
    <a href="/auth/logout" class="sidebar-link"><span class="icon">↩</span> Sign Out</a>
  </div>
</aside>

<main class="main">
  <div class="page-header">
    <div>
      <h1>Scheduled Events</h1>
      <#if circle??><p>Events for <strong>${circle.name}</strong></p></#if>
    </div>
    <a href="/providers/${provider.userId?c}/events/new" class="btn-new">+ New Event</a>
  </div>

  <div class="events-list">
    <#if events?has_content>
      <#list events as event>
        <div class="event-card" style="animation-delay:${event?index * 0.05}s">
          <div class="event-date-block">
            <div class="day">📅</div>
          </div>
          <div class="event-info">
            <h3>${event.title!''}</h3>
            <div class="event-meta">
              <#if event.location??>
                <div class="event-meta-item">📍 ${event.location}</div>
              </#if>
              <#if event.eventDate??>
                <div class="event-meta-item">🕐 ${event.eventDate}</div>
              </#if>
              <#if event.status??>
                <span class="status-badge">${event.status}</span>
              </#if>
            </div>
            <#if event.description??>
              <p>${event.description}</p>
            </#if>
          </div>
        </div>
      </#list>
    <#else>
      <div class="empty-state">
        <div class="icon">📅</div>
        <h3>No events yet</h3>
        <p>Create your first meetup to bring your community together.</p>
      </div>
    </#if>
  </div>
</main>
</body>
</html>

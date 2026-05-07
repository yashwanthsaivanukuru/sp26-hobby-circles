<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Events – ${circle.name!""} – HobbyCircles</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --forest: #1a3a2a;
      --forest-mid: #2c5f3f;
      --forest-light: #3d7a54;
      --cream: #f7f2ea;
      --cream-dark: #ede5d4;
      --gold: #c9a84c;
      --text-dark: #1a1a1a;
      --text-mid: #4a4a4a;
      --text-light: #888;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); display: flex; min-height: 100vh; }

    /* SIDEBAR */
    .sidebar {
      width: 240px;
      background: var(--forest);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      position: fixed;
      top: 0; left: 0;
      padding: 32px 0;
    }
    .sidebar-logo {
      font-family: 'Playfair Display', serif;
      font-size: 1.3rem;
      color: var(--cream);
      padding: 0 24px 32px;
      border-bottom: 1px solid rgba(255,255,255,0.08);
      margin-bottom: 16px;
    }
    .sidebar-logo span { color: var(--gold); }
    .sidebar-user {
      padding: 0 24px 24px;
      border-bottom: 1px solid rgba(255,255,255,0.08);
      margin-bottom: 16px;
    }
    .sidebar-user p { font-size: 0.75rem; color: rgba(247,242,234,0.4); text-transform: uppercase; letter-spacing: 0.08em; margin-bottom: 4px; }
    .sidebar-user strong { font-size: 0.875rem; color: var(--cream); font-weight: 500; word-break: break-all; }

    .sidebar-nav { flex: 1; padding: 0 12px; display: flex; flex-direction: column; gap: 2px; }
    .sidebar-link {
      display: flex;
      align-items: center;
      gap: 10px;
      padding: 11px 14px;
      border-radius: 10px;
      color: rgba(247,242,234,0.6);
      text-decoration: none;
      font-size: 0.875rem;
      font-weight: 500;
      transition: all 0.2s;
    }
    .sidebar-link:hover { background: rgba(255,255,255,0.07); color: var(--cream); }
    .sidebar-link.active { background: var(--gold); color: var(--forest); font-weight: 600; }
    .sidebar-link .icon { font-size: 1rem; width: 20px; text-align: center; }
    .sidebar-bottom { padding: 16px 12px 0; border-top: 1px solid rgba(255,255,255,0.08); margin-top: auto; }

    /* MAIN */
    .main { margin-left: 240px; flex: 1; padding: 48px; }

    .page-header { margin-bottom: 40px; }
    .page-header h1 {
      font-family: 'Playfair Display', serif;
      font-size: 2rem;
      color: var(--forest);
      margin-bottom: 6px;
    }
    .page-header p { color: var(--text-light); font-size: 0.9rem; }

    /* TABLE CARD */
    .card {
      background: white;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.05);
      border: 1px solid rgba(0,0,0,0.04);
      overflow: hidden;
    }
    .card-header {
      padding: 24px 28px;
      border-bottom: 1px solid var(--cream-dark);
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .card-header h2 { font-size: 1.05rem; font-weight: 600; color: var(--text-dark); }

    table { width: 100%; border-collapse: collapse; }
    thead { background: var(--cream); }
    thead th {
      padding: 12px 20px;
      text-align: left;
      font-size: 0.75rem;
      font-weight: 600;
      text-transform: uppercase;
      letter-spacing: 0.06em;
      color: var(--text-light);
    }
    tbody td {
      padding: 18px 20px;
      border-bottom: 1px solid rgba(0,0,0,0.04);
      font-size: 0.9rem;
      color: var(--text-mid);
      vertical-align: middle;
    }
    tbody tr:last-child td { border-bottom: none; }
    tbody tr:hover td { background: rgba(247,242,234,0.5); }

    .event-title { font-weight: 600; color: var(--text-dark); }
    .event-meta { font-size: 0.82rem; color: var(--text-light); margin-top: 3px; }

    .badge {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.78rem;
      font-weight: 600;
    }
    .badge-upcoming { background: rgba(41,128,185,0.1); color: #2980b9; }
    .badge-upcoming::before { content: ''; width: 6px; height: 6px; background: #2980b9; border-radius: 50%; }
    .badge-active { background: rgba(39,174,96,0.1); color: #27ae60; }
    .badge-active::before { content: ''; width: 6px; height: 6px; background: #27ae60; border-radius: 50%; }
    .badge-completed { background: rgba(127,140,141,0.1); color: #7f8c8d; }
    .badge-completed::before { content: ''; width: 6px; height: 6px; background: #7f8c8d; border-radius: 50%; }
    .badge-cancelled { background: rgba(231,76,60,0.1); color: #e74c3c; }
    .badge-cancelled::before { content: ''; width: 6px; height: 6px; background: #e74c3c; border-radius: 50%; }

    .btn-back {
      display: inline-block;
      margin-top: 28px;
      padding: 11px 24px;
      background: var(--forest);
      color: var(--cream);
      border-radius: 10px;
      text-decoration: none;
      font-weight: 600;
      font-size: 0.875rem;
      transition: background 0.2s;
    }
    .btn-back:hover { background: var(--forest-mid); }

    .empty-state {
      padding: 80px 24px;
      text-align: center;
      color: var(--text-light);
    }
    .empty-state .icon { font-size: 3rem; margin-bottom: 16px; }
    .empty-state h3 { color: var(--text-mid); margin-bottom: 8px; font-size: 1.1rem; }
  </style>
</head>
<body>

<aside class="sidebar">
  <div class="sidebar-logo">Hobby<span>Circles</span></div>
  <div class="sidebar-user">
    <p>Signed in as</p>
    <strong>${userEmail!''}</strong>
  </div>
  <nav class="sidebar-nav">
    <a href="/hobbyist/dashboard" class="sidebar-link"><span class="icon">📋</span> My Circles</a>
    <a href="/search" class="sidebar-link"><span class="icon">🔍</span> Explore</a>
    <a href="/profile/edit/1" class="sidebar-link"><span class="icon">👤</span> Edit Profile</a>
  </nav>
  <div class="sidebar-bottom">
    <a href="/auth/logout" class="sidebar-link"><span class="icon">↩</span> Sign Out</a>
  </div>
</aside>

<main class="main">
  <div class="page-header">
    <h1>Events for ${circle.name!""}</h1>
    <p>${circle.category!""} &bull; ${circle.city!""}</p>
  </div>

  <div class="card">
    <div class="card-header">
      <h2>Upcoming & Past Events</h2>
    </div>
    <#if events?? && events?has_content>
      <table>
        <thead>
          <tr>
            <th>Event</th>
            <th>Date</th>
            <th>Location</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <#list events as event>
            <tr>
              <td>
                <div class="event-title">${event.title!""}</div>
                <#if event.description?? && event.description?has_content>
                  <div class="event-meta">${event.description}</div>
                </#if>
              </td>
              <td>${event.eventDate?string("MMM dd, yyyy 'at' hh:mm a")}</td>
              <td>📍 ${event.location!""}</td>
              <td>
                <#if event.status?string == "UPCOMING"><span class="badge badge-upcoming">Upcoming</span>
                <#elseif event.status?string == "ACTIVE"><span class="badge badge-active">Active</span>
                <#elseif event.status?string == "COMPLETED"><span class="badge badge-completed">Completed</span>
                <#elseif event.status?string == "CANCELLED"><span class="badge badge-cancelled">Cancelled</span>
                <#else><span class="badge badge-upcoming">${event.status!""}</span>
                </#if>
              </td>
            </tr>
          </#list>
        </tbody>
      </table>
    <#else>
      <div class="empty-state">
        <div class="icon">📅</div>
        <h3>No events yet</h3>
        <p>The provider hasn't scheduled any events for this circle yet.</p>
      </div>
    </#if>
  </div>

  <a href="/hobbyist/dashboard" class="btn-back">← Back to Dashboard</a>
</main>

</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>My Dashboard – HobbyCircles</title>
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

    /* STATS ROW */
    .stats-row { display: flex; gap: 16px; margin-bottom: 40px; }
    .stat-card {
      flex: 1;
      background: white;
      border-radius: 14px;
      padding: 24px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.05);
      border: 1px solid rgba(0,0,0,0.04);
    }
    .stat-card .label { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.08em; color: var(--text-light); margin-bottom: 8px; }
    .stat-card .value { font-family: 'Playfair Display', serif; font-size: 2rem; color: var(--forest); }
    .stat-card .sub { font-size: 0.8rem; color: var(--text-light); margin-top: 4px; }

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

    .ref-id { font-family: monospace; font-size: 0.8rem; color: var(--text-light); }
    .circle-name { font-weight: 600; color: var(--text-dark); }
    .badge-active {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      background: rgba(39,174,96,0.1);
      color: #27ae60;
      padding: 4px 12px;
      border-radius: 20px;
      font-size: 0.78rem;
      font-weight: 600;
    }
    .badge-active::before { content: ''; width: 6px; height: 6px; background: #27ae60; border-radius: 50%; }

    .btn-review {
      padding: 7px 16px;
      background: transparent;
      border: 1.5px solid var(--gold);
      color: #8a6d1a;
      border-radius: 8px;
      font-size: 0.8rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
      font-family: 'DM Sans', sans-serif;
    }
    .btn-review:hover { background: var(--gold); color: var(--forest); }

    .btn-events {
      padding: 7px 16px;
      background: transparent;
      border: 1.5px solid #2980b9;
      color: #2980b9;
      border-radius: 8px;
      font-size: 0.8rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
      font-family: 'DM Sans', sans-serif;
      margin-right: 6px;
    }
    .btn-events:hover { background: #2980b9; color: white; }

    .btn-leave {
      padding: 7px 16px;
      background: transparent;
      border: 1.5px solid #e74c3c;
      color: #e74c3c;
      border-radius: 8px;
      font-size: 0.8rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.2s;
      font-family: 'DM Sans', sans-serif;
      margin-left: 6px;
    }
    .btn-leave:hover { background: #e74c3c; color: white; }

    .empty-state {
      padding: 80px 24px;
      text-align: center;
      color: var(--text-light);
    }
    .empty-state .icon { font-size: 3rem; margin-bottom: 16px; }
    .empty-state h3 { color: var(--text-mid); margin-bottom: 8px; font-size: 1.1rem; }
    .btn-explore {
      display: inline-block;
      margin-top: 16px;
      padding: 11px 24px;
      background: var(--forest);
      color: var(--cream);
      border-radius: 10px;
      text-decoration: none;
      font-weight: 600;
      font-size: 0.875rem;
      transition: background 0.2s;
    }
    .btn-explore:hover { background: var(--forest-mid); }

    .alert {
      background: #d4edda;
      border: 1px solid #c3e6cb;
      color: #155724;
      padding: 0.75rem 1rem;
      border-radius: 8px;
      margin-bottom: 1.5rem;
    }
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
    <a href="/hobbyist/dashboard" class="sidebar-link active"><span class="icon">📋</span> My Circles</a>
    <a href="/search" class="sidebar-link"><span class="icon">🔍</span> Explore</a>
    <a href="/profile/edit/1" class="sidebar-link"><span class="icon">👤</span> Edit Profile</a>
  </nav>
  <div class="sidebar-bottom">
    <a href="/auth/logout" class="sidebar-link"><span class="icon">↩</span> Sign Out</a>
  </div>
</aside>

<main class="main">
  <div class="page-header">
    <h1>My Dashboard</h1>
    <p>Welcome back! Here's an overview of your hobby circles.</p>
  </div>

  <#if successMessage??>
    <div class="alert">${successMessage}</div>
  </#if>

  <div class="stats-row">
    <div class="stat-card">
      <div class="label">Active Memberships</div>
      <div class="value">${memberships?size}</div>
      <div class="sub">circles joined</div>
    </div>
    <div class="stat-card">
      <div class="label">Account</div>
      <div class="value" style="font-size:1.1rem; padding-top:6px;">${userEmail!''}</div>
      <div class="sub">hobbyist account</div>
    </div>
    <div class="stat-card">
      <div class="label">Status</div>
      <div class="value" style="font-size:1.4rem; padding-top:4px;">✓ Active</div>
      <div class="sub">membership standing</div>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <h2>My Active Memberships</h2>
      <a href="/search" style="font-size:0.85rem; color:var(--forest-light); text-decoration:none; font-weight:600;">+ Find More Circles</a>
    </div>
    <#if memberships?? && (memberships?size > 0)>
      <table>
        <thead>
          <tr>
            <th>Reference</th>
            <th>Circle Name</th>
            <th>Status</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <#list memberships as m>
            <tr>
              <td><span class="ref-id">#MBR-${m.membershipId}</span></td>
              <td><span class="circle-name">${m.circle.name!''}</span></td>
              <td><span class="badge-active">Active Member</span></td>
              <td>
                <a href="/circle/${m.circle.circleId}/events" class="btn-events">📅 View Events</a>
                <a href="/review/${m.circle.circleId}" class="btn-review">⭐ Write Review</a>
                <form method="post" action="/leave/${m.membershipId}" style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to leave this circle?')">
                  <button type="submit" class="btn-leave">✕ Leave</button>
                </form>
              </td>
            </tr>
          </#list>
        </tbody>
      </table>
    <#else>
      <div class="empty-state">
        <div class="icon">🌿</div>
        <h3>No circles yet</h3>
        <p>You haven't joined any hobby circles. Explore and find your community!</p>
        <a href="/search" class="btn-explore">Browse Circles →</a>
      </div>
    </#if>
  </div>
</main>

</body>
</html>

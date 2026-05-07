<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Provider Dashboard – HobbyCircles</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --forest: #1a3a2a; --forest-mid: #2c5f3f; --forest-light: #3d7a54;
      --cream: #f7f2ea; --cream-dark: #ede5d4; --gold: #c9a84c;
      --text-dark: #1a1a1a; --text-mid: #4a4a4a; --text-light: #888;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); display: flex; min-height: 100vh; }

    .sidebar {
      width: 240px; background: var(--forest); min-height: 100vh;
      display: flex; flex-direction: column; position: fixed; top: 0; left: 0; padding: 32px 0;
    }
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

    /* Circle info card */
    .circle-card {
      background: linear-gradient(135deg, var(--forest-mid), var(--forest));
      border-radius: 20px;
      padding: 36px;
      color: var(--cream);
      margin-bottom: 32px;
      position: relative;
      overflow: hidden;
      animation: fadeUp 0.4s ease both;
    }
    .circle-card::before {
      content: '';
      position: absolute;
      width: 300px; height: 300px;
      background: radial-gradient(circle, rgba(201,168,76,0.12), transparent 70%);
      top: -80px; right: -80px;
      border-radius: 50%;
    }
    .circle-card .label { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.1em; color: var(--gold); margin-bottom: 10px; font-weight: 600; }
    .circle-card h2 { font-family: 'Playfair Display', serif; font-size: 1.8rem; margin-bottom: 8px; position: relative; }
    .circle-card p { color: rgba(247,242,234,0.65); font-size: 0.875rem; line-height: 1.6; font-weight: 300; margin-bottom: 20px; position: relative; }
    .circle-meta { display: flex; gap: 20px; position: relative; }
    .circle-meta-item { display: flex; align-items: center; gap: 6px; font-size: 0.82rem; color: rgba(247,242,234,0.65); }
    .circle-meta-item strong { color: var(--cream); }

    .no-circle-card {
      background: white;
      border-radius: 16px;
      padding: 48px;
      text-align: center;
      border: 2px dashed var(--cream-dark);
      margin-bottom: 32px;
      animation: fadeUp 0.4s ease both;
    }
    .no-circle-card .icon { font-size: 3rem; margin-bottom: 16px; }
    .no-circle-card h3 { color: var(--text-mid); margin-bottom: 8px; font-size: 1.1rem; }
    .no-circle-card p { color: var(--text-light); font-size: 0.875rem; margin-bottom: 20px; }
    .btn-create { display: inline-block; padding: 12px 28px; background: var(--forest); color: var(--cream); border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.9rem; transition: background 0.2s; }
    .btn-create:hover { background: var(--forest-mid); }

    /* Menu grid */
    .grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 16px; animation: fadeUp 0.4s ease 0.1s both; }
    .menu-card {
      background: white;
      border-radius: 16px;
      padding: 28px 24px;
      text-decoration: none;
      border: 1px solid rgba(0,0,0,0.04);
      box-shadow: 0 2px 12px rgba(0,0,0,0.05);
      transition: transform 0.2s, box-shadow 0.2s;
      display: block;
    }
    .menu-card:hover { transform: translateY(-4px); box-shadow: 0 8px 24px rgba(0,0,0,0.1); }
    .menu-card .card-icon {
      width: 48px; height: 48px;
      background: linear-gradient(135deg, var(--forest-mid), var(--forest-light));
      border-radius: 12px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.3rem;
      margin-bottom: 16px;
    }
    .menu-card h3 { font-size: 0.95rem; font-weight: 600; color: var(--text-dark); margin-bottom: 6px; }
    .menu-card p { font-size: 0.8rem; color: var(--text-light); line-height: 1.5; }
    .menu-card .arrow { margin-top: 16px; font-size: 0.8rem; color: var(--forest-light); font-weight: 600; }

    @keyframes fadeUp { from { opacity: 0; transform: translateY(12px); } to { opacity: 1; transform: translateY(0); } }
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
    <a href="/providers/${provider.userId?c}" class="sidebar-link active"><span class="icon">🏠</span> Dashboard</a>
    <a href="/providers/${provider.userId?c}/circle" class="sidebar-link"><span class="icon">⚙️</span> My Circle</a>
    <a href="/providers/${provider.userId?c}/reviews" class="sidebar-link"><span class="icon">⭐</span> Reviews</a>
    <a href="/providers/${provider.userId?c}/statistics" class="sidebar-link"><span class="icon">📊</span> Statistics</a>
    <a href="/providers/${provider.userId?c}/events" class="sidebar-link"><span class="icon">📅</span> Events</a>
  </nav>
  <div class="sidebar-bottom">
    <a href="/auth/logout" class="sidebar-link"><span class="icon">↩</span> Sign Out</a>
  </div>
</aside>

<main class="main">
  <div class="page-header">
    <h1>Provider Dashboard</h1>
    <p>Manage your hobby circle and community</p>
  </div>

  <#if circle??>
    <div class="circle-card">
      <div class="label">Your Circle</div>
      <h2>${circle.name}</h2>
      <p>${circle.description!''}</p>
      <div class="circle-meta">
        <#if circle.category??>
          <div class="circle-meta-item">🏷 <strong>${circle.category}</strong></div>
        </#if>
        <#if circle.city??>
          <div class="circle-meta-item">📍 <strong>${circle.city}</strong></div>
        </#if>
      </div>
    </div>
  <#else>
    <div class="no-circle-card">
      <div class="icon">🌱</div>
      <h3>No circle yet</h3>
      <p>Create your hobby circle and start building your community.</p>
      <a href="/providers/${provider.userId?c}/circle" class="btn-create">Create Your Circle →</a>
    </div>
  </#if>

  <div class="grid">
    <a href="/providers/${provider.userId?c}/circle" class="menu-card">
      <div class="card-icon">✏️</div>
      <h3>Create / Edit Circle</h3>
      <p>Set up or update your circle's name, category, and description.</p>
      <div class="arrow">Manage →</div>
    </a>
    <a href="/providers/${provider.userId?c}/reviews" class="menu-card">
      <div class="card-icon">⭐</div>
      <h3>Manage Reviews</h3>
      <p>Read member feedback and reply to their reviews.</p>
      <div class="arrow">View →</div>
    </a>
    <a href="/providers/${provider.userId?c}/statistics" class="menu-card">
      <div class="card-icon">📊</div>
      <h3>Statistics</h3>
      <p>See your member count, events, and average rating.</p>
      <div class="arrow">View →</div>
    </a>
    <a href="/providers/${provider.userId?c}/events/new" class="menu-card">
      <div class="card-icon">📅</div>
      <h3>Schedule Meetup</h3>
      <p>Create a new event for your circle members.</p>
      <div class="arrow">Create →</div>
    </a>
    <a href="/providers/${provider.userId?c}/events" class="menu-card">
      <div class="card-icon">🗓</div>
      <h3>View Events</h3>
      <p>See all scheduled events for your circle.</p>
      <div class="arrow">View →</div>
    </a>
  </div>
</main>

</body>
</html>

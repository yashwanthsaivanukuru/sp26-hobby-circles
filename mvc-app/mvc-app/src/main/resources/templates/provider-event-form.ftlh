<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Schedule Event – HobbyCircles</title>
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

    .main { margin-left: 240px; flex: 1; padding: 48px; display: flex; align-items: flex-start; justify-content: center; }
    .container { max-width: 640px; width: 100%; }

    .page-header { margin-bottom: 32px; }
    .page-header h1 { font-family: 'Playfair Display', serif; font-size: 2rem; color: var(--forest); margin-bottom: 6px; }
    .page-header p { color: var(--text-light); font-size: 0.9rem; }
    .page-header strong { color: var(--forest-mid); }

    .card { background: white; border-radius: 20px; padding: 40px; box-shadow: 0 4px 24px rgba(0,0,0,0.07); animation: fadeUp 0.4s ease both; }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(12px); } to { opacity: 1; transform: translateY(0); } }

    .form-group { margin-bottom: 22px; }
    label { display: block; font-size: 0.78rem; font-weight: 600; color: var(--text-mid); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 7px; }
    input, textarea {
      width: 100%; padding: 12px 16px; border: 1.5px solid #e0e0e0; border-radius: 10px;
      font-size: 0.93rem; font-family: 'DM Sans', sans-serif; color: var(--text-dark);
      transition: border-color 0.2s, box-shadow 0.2s; background: white;
    }
    input:focus, textarea:focus { outline: none; border-color: var(--forest-light); box-shadow: 0 0 0 3px rgba(61,122,84,0.1); }
    textarea { resize: vertical; min-height: 110px; }

    .form-row { display: flex; gap: 16px; }
    .form-row .form-group { flex: 1; }

    .btn-submit {
      width: 100%; padding: 13px; background: var(--forest); color: var(--cream);
      border: none; border-radius: 10px; font-size: 0.95rem; font-weight: 600;
      cursor: pointer; font-family: 'DM Sans', sans-serif; transition: background 0.2s, transform 0.1s; margin-top: 4px;
    }
    .btn-submit:hover { background: var(--forest-mid); transform: translateY(-1px); }
    .btn-cancel { display: block; text-align: center; margin-top: 12px; color: var(--text-light); font-size: 0.875rem; text-decoration: none; }
    .btn-cancel:hover { color: var(--text-mid); }
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
  <div class="container">
    <div class="page-header">
      <h1>Schedule a Meetup</h1>
      <p>Create a new event for <strong>${circle.name!''}</strong></p>
    </div>

    <div class="card">
      <form action="/providers/${provider.userId?c}/events/save" method="post">

        <div class="form-group">
          <label>Event Title</label>
          <input type="text" name="title" placeholder="e.g. Weekly Hike at Piedmont Park" required>
        </div>

        <div class="form-row">
          <div class="form-group">
            <label>Location</label>
            <input type="text" name="location" placeholder="e.g. Piedmont Park, Atlanta" required>
          </div>
          <div class="form-group">
            <label>Date and Time</label>
            <input type="datetime-local" name="eventDate" required>
          </div>
        </div>

        <div class="form-group">
          <label>Description</label>
          <textarea name="description" placeholder="Describe what you'll be doing, what to bring, etc..."></textarea>
        </div>

        <button type="submit" class="btn-submit">Schedule Event →</button>
        <a href="/providers/${provider.userId?c}" class="btn-cancel">Cancel and go back</a>
      </form>
    </div>
  </div>
</main>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Membership Confirmed – HobbyCircles</title>
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
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); min-height: 100vh; }

    nav {
      background: var(--forest);
      padding: 0 48px;
      display: flex;
      align-items: center;
      height: 64px;
      box-shadow: 0 2px 20px rgba(0,0,0,0.2);
    }
    .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.4rem; color: var(--cream); text-decoration: none; }
    .nav-logo span { color: var(--gold); }
    .nav-links { margin-left: auto; display: flex; gap: 8px; }
    .nav-link { color: rgba(247,242,234,0.7); text-decoration: none; font-size: 0.875rem; font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: all 0.2s; }
    .nav-link:hover { background: rgba(255,255,255,0.08); color: var(--cream); }

    .main { max-width: 760px; margin: 0 auto; padding: 56px 24px; }

    /* Success banner */
    .success-banner {
      background: linear-gradient(135deg, var(--forest-mid), var(--forest));
      border-radius: 20px;
      padding: 48px;
      text-align: center;
      position: relative;
      overflow: hidden;
      margin-bottom: 32px;
      animation: fadeUp 0.5s ease both;
    }
    .success-banner::before {
      content: '';
      position: absolute;
      width: 300px;
      height: 300px;
      background: radial-gradient(circle, rgba(201,168,76,0.15), transparent 70%);
      top: -100px;
      right: -80px;
      border-radius: 50%;
    }
    .checkmark {
      width: 72px;
      height: 72px;
      background: rgba(201,168,76,0.15);
      border: 2px solid var(--gold);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.8rem;
      margin: 0 auto 24px;
      position: relative;
      animation: popIn 0.4s ease 0.2s both;
    }
    @keyframes popIn {
      from { transform: scale(0); opacity: 0; }
      to { transform: scale(1); opacity: 1; }
    }
    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(16px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .success-banner h1 {
      font-family: 'Playfair Display', serif;
      font-size: 2rem;
      color: var(--cream);
      margin-bottom: 10px;
      position: relative;
    }
    .success-banner p { color: rgba(247,242,234,0.65); font-size: 0.95rem; font-weight: 300; position: relative; }

    .actions {
      display: flex;
      gap: 12px;
      justify-content: center;
      margin-top: 28px;
      position: relative;
    }
    .btn-primary {
      padding: 12px 28px;
      background: var(--gold);
      color: var(--forest);
      border-radius: 10px;
      text-decoration: none;
      font-weight: 700;
      font-size: 0.9rem;
      transition: filter 0.2s, transform 0.1s;
    }
    .btn-primary:hover { filter: brightness(1.08); transform: translateY(-1px); }
    .btn-secondary {
      padding: 12px 28px;
      background: rgba(255,255,255,0.1);
      color: var(--cream);
      border-radius: 10px;
      text-decoration: none;
      font-weight: 500;
      font-size: 0.9rem;
      border: 1px solid rgba(255,255,255,0.2);
      transition: background 0.2s;
    }
    .btn-secondary:hover { background: rgba(255,255,255,0.15); }

    /* Memberships table */
    .card {
      background: white;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.06);
      overflow: hidden;
      animation: fadeUp 0.5s ease 0.15s both;
    }
    .card-header {
      padding: 22px 28px;
      border-bottom: 1px solid var(--cream-dark);
      display: flex;
      align-items: center;
      justify-content: space-between;
    }
    .card-header h2 { font-size: 1rem; font-weight: 600; color: var(--text-dark); }
    .card-header span { font-size: 0.8rem; color: var(--text-light); }

    table { width: 100%; border-collapse: collapse; }
    thead { background: var(--cream); }
    thead th { padding: 11px 20px; text-align: left; font-size: 0.73rem; font-weight: 600; text-transform: uppercase; letter-spacing: 0.06em; color: var(--text-light); }
    tbody td { padding: 16px 20px; border-bottom: 1px solid rgba(0,0,0,0.04); font-size: 0.875rem; color: var(--text-mid); vertical-align: middle; }
    tbody tr:last-child td { border-bottom: none; }
    tbody tr:hover td { background: rgba(247,242,234,0.4); }

    .ref { font-family: monospace; font-size: 0.8rem; color: var(--text-light); }
    .circle-name { font-weight: 600; color: var(--text-dark); }
    .badge {
      display: inline-flex;
      align-items: center;
      gap: 5px;
      background: rgba(39,174,96,0.1);
      color: #27ae60;
      padding: 3px 10px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 600;
    }
    .badge::before { content: ''; width: 5px; height: 5px; background: #27ae60; border-radius: 50%; }
    .btn-review {
      padding: 6px 14px;
      background: transparent;
      border: 1.5px solid var(--gold);
      color: #8a6d1a;
      border-radius: 7px;
      font-size: 0.78rem;
      font-weight: 600;
      text-decoration: none;
      transition: all 0.2s;
    }
    .btn-review:hover { background: var(--gold); color: var(--forest); }

    .empty { padding: 48px; text-align: center; color: var(--text-light); font-size: 0.9rem; }
  </style>
</head>
<body>

<nav>
  <a href="/search" class="nav-logo">Hobby<span>Circles</span></a>
  <div class="nav-links">
    <a href="/hobbyist/dashboard" class="nav-link">📋 Dashboard</a>
    <a href="/search" class="nav-link">🔍 Explore</a>
  </div>
</nav>

<div class="main">
  <div class="success-banner">
    <div class="checkmark">✓</div>
    <h1>You're In!</h1>
    <p>Welcome, <strong>${name!"friend"}</strong>. Your membership is now active.</p>
    <div class="actions">
      <a href="/search" class="btn-primary">Explore More Circles</a>
      <a href="/hobbyist/dashboard" class="btn-secondary">Go to Dashboard</a>
    </div>
  </div>

  <div class="card">
    <div class="card-header">
      <h2>My Active Memberships</h2>
      <span>${memberships?size} circle<#if (memberships?size != 1)>s</#if></span>
    </div>
    <#if memberships?? && (memberships?size > 0)>
      <table>
        <thead>
          <tr>
            <th>Reference</th>
            <th>Circle</th>
            <th>Email</th>
            <th>Status</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          <#list memberships as m>
            <tr>
              <td><span class="ref">#MBR-${m.membershipId}</span></td>
              <td><span class="circle-name">${m.circle.name!''}</span></td>
              <td>${userEmail!''}</td>
              <td><span class="badge">Active</span></td>
              <td><a href="/review/${m.circle.circleId}" class="btn-review">⭐ Review</a></td>
            </tr>
          </#list>
        </tbody>
      </table>
    <#else>
      <div class="empty">No memberships yet — join a circle to get started!</div>
    </#if>
  </div>
</div>

</body>
</html>

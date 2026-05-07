<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Explore Circles – HobbyCircles</title>
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
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); color: var(--text-dark); min-height: 100vh; }

    /* NAV */
    nav {
      background: var(--forest);
      padding: 0 48px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      height: 64px;
      position: sticky;
      top: 0;
      z-index: 100;
      box-shadow: 0 2px 20px rgba(0,0,0,0.2);
    }
    .nav-logo {
      font-family: 'Playfair Display', serif;
      font-size: 1.4rem;
      color: var(--cream);
      text-decoration: none;
    }
    .nav-logo span { color: var(--gold); }
    .nav-links { display: flex; align-items: center; gap: 8px; }
    .nav-link {
      color: rgba(247,242,234,0.7);
      text-decoration: none;
      font-size: 0.875rem;
      font-weight: 500;
      padding: 8px 16px;
      border-radius: 8px;
      transition: all 0.2s;
    }
    .nav-link:hover { background: rgba(255,255,255,0.08); color: var(--cream); }
    .nav-link.active {
      background: var(--gold);
      color: var(--forest);
      font-weight: 600;
    }

    /* HERO SEARCH */
    .hero {
      background: linear-gradient(135deg, var(--forest) 0%, var(--forest-mid) 100%);
      padding: 56px 48px;
      text-align: center;
      position: relative;
      overflow: hidden;
    }
    .hero::before {
      content: '';
      position: absolute;
      inset: 0;
      background: radial-gradient(ellipse at 70% 50%, rgba(201,168,76,0.08), transparent 60%);
    }
    .hero h1 {
      font-family: 'Playfair Display', serif;
      font-size: 2.8rem;
      color: var(--cream);
      margin-bottom: 10px;
      position: relative;
    }
    .hero p {
      color: rgba(247,242,234,0.65);
      font-size: 1rem;
      margin-bottom: 32px;
      font-weight: 300;
      position: relative;
    }
    .search-bar {
      display: flex;
      gap: 10px;
      max-width: 560px;
      margin: 0 auto;
      position: relative;
    }
    .search-bar input {
      flex: 1;
      padding: 14px 20px;
      border: none;
      border-radius: 12px;
      font-size: 0.95rem;
      font-family: 'DM Sans', sans-serif;
      background: white;
      color: var(--text-dark);
      box-shadow: 0 4px 20px rgba(0,0,0,0.15);
    }
    .search-bar input:focus { outline: 2px solid var(--gold); }
    .search-bar button {
      padding: 14px 28px;
      background: var(--gold);
      color: var(--forest);
      border: none;
      border-radius: 12px;
      font-weight: 700;
      font-size: 0.9rem;
      cursor: pointer;
      font-family: 'DM Sans', sans-serif;
      transition: background 0.2s, transform 0.1s;
      white-space: nowrap;
    }
    .search-bar button:hover { background: var(--gold); filter: brightness(1.1); transform: translateY(-1px); }

    /* MAIN */
    .main { max-width: 900px; margin: 0 auto; padding: 48px 24px; }

    .section-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 28px;
    }
    .section-header h2 {
      font-family: 'Playfair Display', serif;
      font-size: 1.6rem;
      color: var(--forest);
    }
    .count-badge {
      background: var(--forest);
      color: var(--cream);
      padding: 4px 14px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
    }

    /* CIRCLE CARDS */
    .circles-grid { display: flex; flex-direction: column; gap: 16px; }

    .circle-card {
      background: white;
      border-radius: 16px;
      padding: 28px 32px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 24px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.06);
      transition: transform 0.2s, box-shadow 0.2s;
      border: 1px solid rgba(0,0,0,0.04);
      animation: slideIn 0.4s ease both;
    }
    .circle-card:hover { transform: translateY(-3px); box-shadow: 0 8px 28px rgba(0,0,0,0.1); }

    @keyframes slideIn {
      from { opacity: 0; transform: translateY(12px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .circle-icon {
      width: 56px;
      height: 56px;
      background: linear-gradient(135deg, var(--forest-mid), var(--forest-light));
      border-radius: 14px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.6rem;
      flex-shrink: 0;
    }

    .circle-info { flex: 1; }
    .circle-info h3 {
      font-size: 1.1rem;
      font-weight: 600;
      color: var(--text-dark);
      margin-bottom: 6px;
    }
    .circle-info p {
      font-size: 0.875rem;
      color: var(--text-light);
      line-height: 1.5;
      margin-bottom: 10px;
    }
    .circle-meta { display: flex; gap: 8px; flex-wrap: wrap; }
    .tag {
      padding: 3px 10px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 500;
    }
    .tag-city { background: #e8f4fd; color: #2980b9; }
    .tag-category { background: rgba(61,122,84,0.1); color: var(--forest-mid); }

    .btn-join {
      padding: 11px 24px;
      background: var(--forest);
      color: var(--cream);
      border: none;
      border-radius: 10px;
      font-weight: 600;
      font-size: 0.875rem;
      text-decoration: none;
      white-space: nowrap;
      transition: background 0.2s, transform 0.1s;
      font-family: 'DM Sans', sans-serif;
      flex-shrink: 0;
    }
    .btn-join:hover { background: var(--forest-mid); color: var(--cream); transform: translateY(-1px); }

    .empty-state {
      text-align: center;
      padding: 80px 24px;
      color: var(--text-light);
    }
    .empty-state .icon { font-size: 3rem; margin-bottom: 16px; }
    .empty-state h3 { font-size: 1.2rem; color: var(--text-mid); margin-bottom: 8px; }

    .alert-success {
      background: #d8f3dc;
      color: #1b4332;
      border-left: 3px solid #27ae60;
      padding: 12px 16px;
      border-radius: 8px;
      margin-bottom: 24px;
      font-size: 0.9rem;
    }

    /* Category icons map */
    .cat-art { --icon: '🎨'; }
    .cat-music { --icon: '🎵'; }
    .cat-sports { --icon: '⚽'; }
    .cat-tech { --icon: '💻'; }
    .cat-food { --icon: '🍳'; }
    .cat-outdoor { --icon: '🏕️'; }
    .cat-default { --icon: '🌿'; }
  </style>
</head>
<body>

<nav>
  <a href="/search" class="nav-logo">Hobby<span>Circles</span></a>
  <div class="nav-links">
    <a href="/search" class="nav-link active">🔍 Explore</a>
    <a href="/hobbyist/dashboard" class="nav-link">📋 My Dashboard</a>
    <a href="/auth/logout" class="nav-link">Sign Out</a>
  </div>
</nav>

<div class="hero">
  <h1>Discover Your Circle</h1>
  <p>Find local hobby groups that match your passion</p>
  <form action="/search" method="get" class="search-bar">
    <input type="text" name="query" placeholder="Search by hobby, city, or category..." value="${query!''}">
    <button type="submit">Search →</button>
  </form>
</div>

<div class="main">
  <#if successMessage??>
    <div class="alert-success">✓ ${successMessage}</div>
  </#if>
  <#if message??>
    <div class="alert-success">✓ ${message}</div>
  </#if>

  <div class="section-header">
    <h2>Available Circles</h2>
    <span class="count-badge">${circles?size} circles</span>
  </div>

  <div class="circles-grid">
    <#list circles as circle>
      <div class="circle-card" style="animation-delay: ${circle?index * 0.05}s">
        <div class="circle-icon">
          <#assign cat = circle.category!''>
          <#if cat?lower_case?contains('art')>🎨
          <#elseif cat?lower_case?contains('music')>🎵
          <#elseif cat?lower_case?contains('sport') || cat?lower_case?contains('fitness')>⚽
          <#elseif cat?lower_case?contains('tech') || cat?lower_case?contains('code')>💻
          <#elseif cat?lower_case?contains('food') || cat?lower_case?contains('cook')>🍳
          <#elseif cat?lower_case?contains('outdoor') || cat?lower_case?contains('hike')>🏕️
          <#elseif cat?lower_case?contains('game')>🎮
          <#elseif cat?lower_case?contains('book') || cat?lower_case?contains('read')>📚
          <#else>🌿
          </#if>
        </div>
        <div class="circle-info">
          <h3>${circle.name}</h3>
          <p>${circle.description!''}</p>
          <div class="circle-meta">
            <#if circle.city??>
              <span class="tag tag-city">📍 ${circle.city}</span>
            </#if>
            <#if circle.category??>
              <span class="tag tag-category">${circle.category}</span>
            </#if>
          </div>
        </div>
        <a href="/join/${circle.circleId}" class="btn-join">Join →</a>
      </div>
    <#else>
      <div class="empty-state">
        <div class="icon">🔍</div>
        <h3>No circles found</h3>
        <p>Try searching with different keywords</p>
      </div>
    </#list>
  </div>
</div>

</body>
</html>

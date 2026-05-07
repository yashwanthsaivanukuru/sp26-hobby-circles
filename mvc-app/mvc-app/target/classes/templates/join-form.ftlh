<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Join Circle – HobbyCircles</title>
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
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); min-height: 100vh; display: flex; flex-direction: column; }

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
    .nav-back { margin-left: auto; color: rgba(247,242,234,0.7); text-decoration: none; font-size: 0.875rem; font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: all 0.2s; }
    .nav-back:hover { background: rgba(255,255,255,0.08); color: var(--cream); }

    .page {
      flex: 1;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 48px 24px;
    }

    .container {
      display: flex;
      gap: 40px;
      max-width: 900px;
      width: 100%;
      align-items: flex-start;
    }

    /* Circle info panel */
    .circle-panel {
      width: 280px;
      flex-shrink: 0;
    }
    .circle-preview {
      background: linear-gradient(160deg, var(--forest-mid), var(--forest));
      border-radius: 20px;
      padding: 36px 28px;
      color: var(--cream);
      position: relative;
      overflow: hidden;
    }
    .circle-preview::before {
      content: '';
      position: absolute;
      width: 200px;
      height: 200px;
      background: radial-gradient(circle, rgba(201,168,76,0.15), transparent 70%);
      top: -60px;
      right: -60px;
      border-radius: 50%;
    }
    .circle-emoji { font-size: 2.5rem; margin-bottom: 16px; display: block; }
    .circle-preview h2 { font-family: 'Playfair Display', serif; font-size: 1.4rem; margin-bottom: 10px; line-height: 1.3; }
    .circle-preview p { font-size: 0.875rem; color: rgba(247,242,234,0.65); line-height: 1.6; margin-bottom: 20px; font-weight: 300; }
    .circle-tags { display: flex; flex-direction: column; gap: 8px; }
    .circle-tag { display: flex; align-items: center; gap: 8px; font-size: 0.8rem; color: rgba(247,242,234,0.7); }
    .circle-tag span { width: 6px; height: 6px; background: var(--gold); border-radius: 50%; flex-shrink: 0; }

    /* Form */
    .form-panel {
      flex: 1;
      background: white;
      border-radius: 20px;
      padding: 40px;
      box-shadow: 0 4px 24px rgba(0,0,0,0.08);
    }
    .form-panel h3 {
      font-family: 'Playfair Display', serif;
      font-size: 1.6rem;
      color: var(--forest);
      margin-bottom: 6px;
    }
    .form-panel .subtitle { color: var(--text-light); font-size: 0.875rem; margin-bottom: 32px; }

    .form-group { margin-bottom: 20px; }
    label {
      display: block;
      font-size: 0.78rem;
      font-weight: 600;
      color: var(--text-mid);
      text-transform: uppercase;
      letter-spacing: 0.06em;
      margin-bottom: 7px;
    }
    input, textarea {
      width: 100%;
      padding: 12px 16px;
      border: 1.5px solid #e0e0e0;
      border-radius: 10px;
      font-size: 0.93rem;
      font-family: 'DM Sans', sans-serif;
      color: var(--text-dark);
      transition: border-color 0.2s, box-shadow 0.2s;
      background: white;
    }
    input:focus, textarea:focus {
      outline: none;
      border-color: var(--forest-light);
      box-shadow: 0 0 0 3px rgba(61,122,84,0.1);
    }
    textarea { resize: vertical; min-height: 100px; }

    .form-row { display: flex; gap: 16px; }
    .form-row .form-group { flex: 1; }

    .btn-submit {
      width: 100%;
      padding: 14px;
      background: var(--forest);
      color: var(--cream);
      border: none;
      border-radius: 10px;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      font-family: 'DM Sans', sans-serif;
      transition: background 0.2s, transform 0.1s;
      margin-top: 8px;
    }
    .btn-submit:hover { background: var(--forest-mid); transform: translateY(-1px); }
    .btn-cancel {
      display: block;
      text-align: center;
      margin-top: 12px;
      color: var(--text-light);
      font-size: 0.875rem;
      text-decoration: none;
    }
    .btn-cancel:hover { color: var(--text-mid); }
  </style>
</head>
<body>

<nav>
  <a href="/search" class="nav-logo">Hobby<span>Circles</span></a>
  <a href="/search" class="nav-back">← Back to Circles</a>
</nav>

<div class="page">
  <div class="container">

    <!-- Circle preview -->
    <div class="circle-panel">
      <div class="circle-preview">
        <span class="circle-emoji">🌿</span>
        <h2>${circle.name!''}</h2>
        <p>${circle.description!''}</p>
        <div class="circle-tags">
          <#if circle.city??>
            <div class="circle-tag"><span></span>📍 ${circle.city}</div>
          </#if>
          <#if circle.category??>
            <div class="circle-tag"><span></span>${circle.category}</div>
          </#if>
        </div>
      </div>
    </div>

    <!-- Form -->
    <div class="form-panel">
      <h3>Join This Circle</h3>
      <p class="subtitle">Fill in your details to apply for membership</p>

      <form action="/join/submit" method="post">
        <input type="hidden" name="circleId" value="${circleId}">

        <div class="form-row">
          <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="userName" placeholder="John Doe" required>
          </div>
          <div class="form-group">
            <label>Phone Number</label>
            <input type="tel" name="phone" placeholder="(555) 555-5555" required>
          </div>
        </div>

        <div class="form-group">
          <label>Email Address</label>
          <input type="email" name="email" placeholder="you@example.com" value="${userEmail!''}" required>
        </div>

        <div class="form-group">
          <label>Why do you want to join?</label>
          <textarea name="reason" placeholder="Tell us about your interest in this hobby..." required></textarea>
        </div>

        <button type="submit" class="btn-submit">Submit Application →</button>
        <a href="/search" class="btn-cancel">Cancel and go back</a>
      </form>
    </div>

  </div>
</div>

</body>
</html>

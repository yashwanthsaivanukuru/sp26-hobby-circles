<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HobbyCircles – Welcome</title>
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
      --gold-light: #e8c97a;
      --text-dark: #1a1a1a;
      --text-mid: #4a4a4a;
      --text-light: #888;
      --error: #c0392b;
      --success: #27ae60;
    }

    body {
      font-family: 'DM Sans', sans-serif;
      background-color: var(--forest);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
      overflow: hidden;
    }

    /* Background texture */
    body::before {
      content: '';
      position: fixed;
      inset: 0;
      background:
        radial-gradient(ellipse at 20% 50%, rgba(61,122,84,0.3) 0%, transparent 60%),
        radial-gradient(ellipse at 80% 20%, rgba(201,168,76,0.1) 0%, transparent 50%),
        radial-gradient(ellipse at 60% 80%, rgba(26,58,42,0.8) 0%, transparent 60%);
      pointer-events: none;
    }

    /* Decorative circles */
    body::after {
      content: '';
      position: fixed;
      width: 600px;
      height: 600px;
      border: 1px solid rgba(201,168,76,0.08);
      border-radius: 50%;
      top: -200px;
      right: -200px;
      pointer-events: none;
    }

    .decorative-ring {
      position: fixed;
      width: 400px;
      height: 400px;
      border: 1px solid rgba(201,168,76,0.06);
      border-radius: 50%;
      bottom: -150px;
      left: -100px;
      pointer-events: none;
    }

    .wrapper {
      display: flex;
      width: 900px;
      max-width: 95vw;
      min-height: 560px;
      border-radius: 24px;
      overflow: hidden;
      box-shadow: 0 40px 80px rgba(0,0,0,0.5);
      position: relative;
      z-index: 1;
      animation: fadeUp 0.6s ease both;
    }

    @keyframes fadeUp {
      from { opacity: 0; transform: translateY(24px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* Left panel */
    .panel-left {
      flex: 1;
      background: linear-gradient(160deg, var(--forest-mid), var(--forest));
      padding: 56px 48px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      position: relative;
      overflow: hidden;
    }

    .panel-left::before {
      content: '';
      position: absolute;
      width: 300px;
      height: 300px;
      background: radial-gradient(circle, rgba(201,168,76,0.12), transparent 70%);
      top: -80px;
      right: -80px;
      border-radius: 50%;
    }

    .logo {
      font-family: 'Playfair Display', serif;
      font-size: 1.8rem;
      color: var(--cream);
      letter-spacing: -0.02em;
    }

    .logo span {
      color: var(--gold);
    }

    .panel-tagline {
      position: relative;
      z-index: 1;
    }

    .panel-tagline h2 {
      font-family: 'Playfair Display', serif;
      font-size: 2.4rem;
      color: var(--cream);
      line-height: 1.2;
      margin-bottom: 16px;
    }

    .panel-tagline p {
      color: rgba(247,242,234,0.6);
      font-size: 0.95rem;
      line-height: 1.6;
      font-weight: 300;
    }

    .features {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }

    .feature {
      display: flex;
      align-items: center;
      gap: 12px;
      color: rgba(247,242,234,0.75);
      font-size: 0.875rem;
    }

    .feature-dot {
      width: 6px;
      height: 6px;
      background: var(--gold);
      border-radius: 50%;
      flex-shrink: 0;
    }

    /* Right panel */
    .panel-right {
      width: 420px;
      background: var(--cream);
      padding: 48px 44px;
      display: flex;
      flex-direction: column;
      justify-content: center;
    }

    .tabs {
      display: flex;
      gap: 4px;
      margin-bottom: 32px;
      background: var(--cream-dark);
      padding: 4px;
      border-radius: 10px;
    }

    .tab {
      flex: 1;
      padding: 9px;
      text-align: center;
      cursor: pointer;
      font-size: 0.875rem;
      font-weight: 500;
      color: var(--text-mid);
      border: none;
      background: none;
      border-radius: 7px;
      transition: all 0.2s;
      font-family: 'DM Sans', sans-serif;
    }

    .tab.active {
      background: white;
      color: var(--forest);
      font-weight: 600;
      box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    }

    .form { display: none; }
    .form.active { display: block; }

    .form-group { margin-bottom: 18px; }

    label {
      display: block;
      font-size: 0.8rem;
      font-weight: 600;
      color: var(--text-mid);
      text-transform: uppercase;
      letter-spacing: 0.06em;
      margin-bottom: 7px;
    }

    input, select {
      width: 100%;
      padding: 11px 14px;
      border: 1.5px solid #ddd;
      border-radius: 9px;
      font-size: 0.93rem;
      font-family: 'DM Sans', sans-serif;
      color: var(--text-dark);
      background: white;
      transition: border-color 0.2s, box-shadow 0.2s;
    }

    input:focus, select:focus {
      outline: none;
      border-color: var(--forest-light);
      box-shadow: 0 0 0 3px rgba(61,122,84,0.1);
    }

    .btn-primary {
      width: 100%;
      padding: 13px;
      background: var(--forest);
      color: var(--cream);
      border: none;
      border-radius: 9px;
      font-size: 0.95rem;
      font-weight: 600;
      cursor: pointer;
      margin-top: 8px;
      font-family: 'DM Sans', sans-serif;
      transition: background 0.2s, transform 0.1s;
      letter-spacing: 0.01em;
    }

    .btn-primary:hover { background: var(--forest-mid); transform: translateY(-1px); }
    .btn-primary:active { transform: translateY(0); }

    .alert {
      padding: 11px 14px;
      border-radius: 8px;
      margin-bottom: 18px;
      font-size: 0.875rem;
      font-weight: 500;
    }

    .alert-error { background: #fdf0ef; color: var(--error); border-left: 3px solid var(--error); }
    .alert-success { background: #d8f3dc; color: #1b4332; border-left: 3px solid var(--success); }

    .switch-text {
      text-align: center;
      margin-top: 18px;
      font-size: 0.85rem;
      color: var(--text-light);
    }

    .switch-text a {
      color: var(--forest-light);
      cursor: pointer;
      font-weight: 600;
      text-decoration: none;
    }

    .role-pills {
      display: flex;
      gap: 8px;
      margin-bottom: 18px;
    }

    .pill {
      flex: 1;
      padding: 10px 8px;
      border: 1.5px solid #ddd;
      border-radius: 9px;
      text-align: center;
      cursor: pointer;
      font-size: 0.85rem;
      color: var(--text-mid);
      transition: all 0.2s;
      font-family: 'DM Sans', sans-serif;
      background: white;
    }

    .pill.selected {
      border-color: var(--forest-light);
      background: rgba(61,122,84,0.07);
      color: var(--forest);
      font-weight: 600;
    }

    @media (max-width: 700px) {
      .panel-left { display: none; }
      .panel-right { width: 100%; }
    }
  </style>
</head>
<body>
<div class="decorative-ring"></div>
<div class="wrapper">
  <!-- Left branding panel -->
  <div class="panel-left">
    <div class="logo">Hobby<span>Circles</span></div>
    <div class="panel-tagline">
      <h2>Find your people. Share your passion.</h2>
      <p>Connect with local hobby communities and discover groups that share your interests.</p>
    </div>
    <div class="features">
      <div class="feature"><div class="feature-dot"></div>Browse hundreds of local circles</div>
      <div class="feature"><div class="feature-dot"></div>Join and connect instantly</div>
      <div class="feature"><div class="feature-dot"></div>Share reviews and experiences</div>
      <div class="feature"><div class="feature-dot"></div>Host and manage your own circle</div>
    </div>
  </div>

  <!-- Right form panel -->
  <div class="panel-right">
    <#if errorMessage??>
      <div class="alert alert-error">${errorMessage}</div>
    </#if>
    <#if successMessage??>
      <div class="alert alert-success">${successMessage}</div>
    </#if>

    <div class="tabs">
      <button class="tab active" onclick="showTab('login')">Sign In</button>
      <button class="tab" onclick="showTab('register')">Register</button>
    </div>

    <!-- LOGIN -->
    <div id="loginForm" class="form active">
      <form action="/auth/login" method="post">
        <div class="form-group">
          <label>Email Address</label>
          <input type="email" name="email" placeholder="you@example.com" required>
        </div>
        <div class="form-group">
          <label>Password</label>
          <input type="password" name="password" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn-primary">Sign In →</button>
      </form>
      <p class="switch-text">New here? <a onclick="showTab('register')">Create an account</a></p>
    </div>

    <!-- REGISTER -->
    <div id="registerForm" class="form">
      <form action="/auth/register" method="post">
        <div class="form-group">
          <label>I want to...</label>
          <div class="role-pills">
            <div class="pill selected" onclick="selectRole('HOBBYIST', this)">🎯 Join Circles</div>
            <div class="pill" onclick="selectRole('PROVIDER', this)">🏆 Lead a Circle</div>
          </div>
          <input type="hidden" id="roleInput" name="role" value="HOBBYIST">
        </div>
        <div class="form-group">
          <label>Email Address</label>
          <input type="email" name="email" placeholder="you@example.com" required>
        </div>
        <div class="form-group">
          <label>Password</label>
          <input type="password" name="password" placeholder="Min. 6 characters" required minlength="6">
        </div>
        <button type="submit" class="btn-primary">Create Account →</button>
      </form>
      <p class="switch-text">Already have an account? <a onclick="showTab('login')">Sign in</a></p>
    </div>
  </div>
</div>

<script>
  function showTab(tab) {
    document.getElementById('loginForm').classList.toggle('active', tab === 'login');
    document.getElementById('registerForm').classList.toggle('active', tab === 'register');
    document.querySelectorAll('.tab').forEach((t, i) => {
      t.classList.toggle('active', (tab === 'login' && i === 0) || (tab === 'register' && i === 1));
    });
  }
  function selectRole(role, el) {
    document.querySelectorAll('.pill').forEach(p => p.classList.remove('selected'));
    el.classList.add('selected');
    document.getElementById('roleInput').value = role;
  }
  if (new URLSearchParams(window.location.search).get('tab') === 'register') showTab('register');
</script>
</body>
</html>

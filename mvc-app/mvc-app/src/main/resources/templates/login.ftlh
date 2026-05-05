<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>HobbyCircles – Welcome</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    :root {
      --forest:   #2c6e49;
      --leaf:     #52b788;
      --mint:     #d8f3dc;
      --bark:     #1b4332;
      --sand:     #f8f5f0;
      --warm-grey:#6b6b6b;
      --error:    #c0392b;
      --card-bg:  #ffffff;
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: 'DM Sans', sans-serif;
      background: var(--sand);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    /* ── PAGE LAYOUT ── */
    .page-wrap {
      flex: 1;
      display: grid;
      grid-template-columns: 1fr 1fr;
      min-height: 100vh;
    }

    /* ── LEFT PANEL ── */
    .hero-panel {
      background: linear-gradient(160deg, var(--bark) 0%, var(--forest) 60%, var(--leaf) 100%);
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 60px 56px;
      color: #fff;
      position: relative;
      overflow: hidden;
    }

    .hero-panel::before {
      content: '';
      position: absolute;
      width: 420px; height: 420px;
      border-radius: 50%;
      border: 60px solid rgba(255,255,255,0.05);
      top: -80px; left: -80px;
    }
    .hero-panel::after {
      content: '';
      position: absolute;
      width: 280px; height: 280px;
      border-radius: 50%;
      border: 40px solid rgba(255,255,255,0.05);
      bottom: -40px; right: -40px;
    }

    .brand {
      font-family: 'Playfair Display', serif;
      font-size: 2.6rem;
      font-weight: 700;
      letter-spacing: -0.5px;
      margin-bottom: 12px;
      position: relative;
      z-index: 1;
    }

    .brand span { color: var(--leaf); }

    .tagline {
      font-size: 1.05rem;
      font-weight: 300;
      opacity: 0.85;
      line-height: 1.7;
      max-width: 340px;
      margin-bottom: 52px;
      position: relative;
      z-index: 1;
    }

    .feature-list {
      list-style: none;
      position: relative;
      z-index: 1;
    }

    .feature-list li {
      display: flex;
      align-items: flex-start;
      gap: 14px;
      margin-bottom: 22px;
    }

    .feature-icon {
      width: 38px; height: 38px;
      background: rgba(255,255,255,0.15);
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.1rem;
      flex-shrink: 0;
    }

    .feature-text strong {
      display: block;
      font-size: 0.95rem;
      font-weight: 600;
      margin-bottom: 2px;
    }

    .feature-text p {
      font-size: 0.82rem;
      opacity: 0.72;
      line-height: 1.5;
    }

    /* ── RIGHT PANEL ── */
    .auth-panel {
      background: var(--card-bg);
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 48px 56px;
    }

    .auth-box {
      width: 100%;
      max-width: 420px;
    }

    /* ── TAB SWITCHER ── */
    .tabs {
      display: flex;
      background: var(--sand);
      border-radius: 12px;
      padding: 4px;
      margin-bottom: 36px;
    }

    .tab-btn {
      flex: 1;
      padding: 10px;
      border: none;
      background: transparent;
      border-radius: 10px;
      font-family: 'DM Sans', sans-serif;
      font-size: 0.93rem;
      font-weight: 500;
      color: var(--warm-grey);
      cursor: pointer;
      transition: all 0.2s;
    }

    .tab-btn.active {
      background: #fff;
      color: var(--forest);
      font-weight: 600;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    /* ── FORMS ── */
    .auth-form { display: none; }
    .auth-form.active { display: block; }

    .form-title {
      font-family: 'Playfair Display', serif;
      font-size: 1.7rem;
      color: var(--bark);
      margin-bottom: 6px;
    }

    .form-subtitle {
      font-size: 0.88rem;
      color: var(--warm-grey);
      margin-bottom: 28px;
    }

    .field {
      margin-bottom: 18px;
    }

    .field label {
      display: block;
      font-size: 0.82rem;
      font-weight: 600;
      color: var(--bark);
      margin-bottom: 6px;
      letter-spacing: 0.3px;
      text-transform: uppercase;
    }

    .field input,
    .field select,
    .field textarea {
      width: 100%;
      padding: 11px 14px;
      border: 1.5px solid #e0e0e0;
      border-radius: 10px;
      font-family: 'DM Sans', sans-serif;
      font-size: 0.93rem;
      color: #333;
      background: var(--sand);
      transition: border-color 0.2s, box-shadow 0.2s;
      outline: none;
    }

    .field input:focus,
    .field select:focus,
    .field textarea:focus {
      border-color: var(--forest);
      background: #fff;
      box-shadow: 0 0 0 3px rgba(44,110,73,0.12);
    }

    .field textarea { resize: vertical; min-height: 80px; }

    .field-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 14px;
    }

    .role-select {
      appearance: none;
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath fill='%232c6e49' d='M6 8L0 0h12z'/%3E%3C/svg%3E");
      background-repeat: no-repeat;
      background-position: right 14px center;
      padding-right: 36px;
    }

    /* ── SUBMIT BUTTON ── */
    .submit-btn {
      width: 100%;
      padding: 13px;
      background: var(--forest);
      color: #fff;
      border: none;
      border-radius: 10px;
      font-family: 'DM Sans', sans-serif;
      font-size: 1rem;
      font-weight: 600;
      cursor: pointer;
      margin-top: 8px;
      transition: background 0.2s, transform 0.1s;
      letter-spacing: 0.2px;
    }

    .submit-btn:hover  { background: var(--bark); }
    .submit-btn:active { transform: scale(0.99); }

    /* ── ALERTS ── */
    .alert {
      padding: 12px 16px;
      border-radius: 8px;
      font-size: 0.88rem;
      margin-bottom: 20px;
      font-weight: 500;
    }
    .alert-error   { background: #fdf0ef; color: var(--error); border-left: 3px solid var(--error); }
    .alert-success { background: var(--mint); color: var(--bark); border-left: 3px solid var(--forest); }

    /* ── SWITCH LINK ── */
    .switch-link {
      text-align: center;
      margin-top: 24px;
      font-size: 0.87rem;
      color: var(--warm-grey);
    }
    .switch-link a {
      color: var(--forest);
      text-decoration: none;
      font-weight: 600;
      cursor: pointer;
    }
    .switch-link a:hover { text-decoration: underline; }

    /* ── DIVIDER ── */
    .divider {
      display: flex;
      align-items: center;
      gap: 12px;
      margin: 20px 0;
      color: #ccc;
      font-size: 0.8rem;
    }
    .divider::before, .divider::after {
      content: '';
      flex: 1;
      height: 1px;
      background: #eee;
    }

    /* ── ROLE PILLS ── */
    .role-pills {
      display: flex;
      gap: 10px;
      margin-bottom: 4px;
    }
    .role-pill {
      flex: 1;
      padding: 10px;
      border: 1.5px solid #e0e0e0;
      border-radius: 10px;
      background: var(--sand);
      cursor: pointer;
      text-align: center;
      font-size: 0.87rem;
      font-weight: 500;
      color: var(--warm-grey);
      transition: all 0.2s;
    }
    .role-pill.selected {
      border-color: var(--forest);
      background: var(--mint);
      color: var(--bark);
      font-weight: 600;
    }
    .role-pill .pill-icon { font-size: 1.3rem; display: block; margin-bottom: 4px; }

    #roleInput { display: none; }

    /* ── FOOTER ── */
    footer {
      background: var(--bark);
      color: rgba(255,255,255,0.45);
      text-align: center;
      padding: 14px;
      font-size: 0.78rem;
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 768px) {
      .page-wrap { grid-template-columns: 1fr; }
      .hero-panel { padding: 40px 32px; min-height: auto; }
      .auth-panel { padding: 36px 24px; }
      .field-row { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

<div class="page-wrap">

  <!-- ── LEFT: HERO ── -->
  <div class="hero-panel">
    <div class="brand">Hobby<span>Circles</span></div>
    <p class="tagline">Find your people. Explore local interest groups and connect with hobbyists in your city.</p>

    <ul class="feature-list">
      <li>
        <div class="feature-icon">🔍</div>
        <div class="feature-text">
          <strong>Discover Circles</strong>
          <p>Browse hobby groups by category or city</p>
        </div>
      </li>
      <li>
        <div class="feature-icon">📅</div>
        <div class="feature-text">
          <strong>Join Meetups</strong>
          <p>RSVP to events and see upcoming activities</p>
        </div>
      </li>
      <li>
        <div class="feature-icon">⭐</div>
        <div class="feature-text">
          <strong>Leave Reviews</strong>
          <p>Share your experience and help others discover great groups</p>
        </div>
      </li>
      <li>
        <div class="feature-icon">🏆</div>
        <div class="feature-text">
          <strong>Lead a Circle</strong>
          <p>Create and manage your own hobby community</p>
        </div>
      </li>
    </ul>
  </div>

  <!-- ── RIGHT: AUTH FORMS ── -->
  <div class="auth-panel">
    <div class="auth-box">

      <!-- Error / Success flash messages from Spring -->
      <#if errorMessage??>
        <div class="alert alert-error">${errorMessage}</div>
      </#if>
      <#if successMessage??>
        <div class="alert alert-success">${successMessage}</div>
      </#if>

      <!-- Tab Switcher -->
      <div class="tabs" id="authTabs">
        <button class="tab-btn active" onclick="showTab('login')">Sign In</button>
        <button class="tab-btn" onclick="showTab('register')">Create Account</button>
      </div>

      <!-- ── LOGIN FORM ── -->
      <div id="loginForm" class="auth-form active">
        <h2 class="form-title">Welcome back</h2>
        <p class="form-subtitle">Sign in to access your circles and events</p>

        <form action="/auth/login" method="post">
          <div class="field">
            <label for="loginEmail">Email Address</label>
            <input type="email" id="loginEmail" name="email"
                   placeholder="you@example.com" required
                   <#if loginEmail??>value="${loginEmail}"</#if>>
          </div>
          <div class="field">
            <label for="loginPassword">Password</label>
            <input type="password" id="loginPassword" name="password"
                   placeholder="••••••••" required>
          </div>

          <!-- Hidden role field — auto-detected server-side but kept for UX hint -->
          <button type="submit" class="submit-btn">Sign In →</button>
        </form>

        <p class="switch-link">
          Don't have an account? <a onclick="showTab('register')">Create one free</a>
        </p>
      </div>

      <!-- ── REGISTER FORM ── -->
      <div id="registerForm" class="auth-form">
        <h2 class="form-title">Join HobbyCircles</h2>
        <p class="form-subtitle">Create your account and start connecting</p>

        <form action="/auth/register" method="post" id="regForm">

          <!-- Role Selection Pills -->
          <div class="field">
            <label>I want to…</label>
            <div class="role-pills">
              <div class="role-pill selected" onclick="selectRole('HOBBYIST', this)">
                <span class="pill-icon">🎯</span>
                Join Circles
              </div>
              <div class="role-pill" onclick="selectRole('PROVIDER', this)">
                <span class="pill-icon">🏆</span>
                Lead a Circle
              </div>
            </div>
            <input type="hidden" id="roleInput" name="role" value="HOBBYIST">
          </div>

          <div class="field-row">
            <div class="field">
              <label for="regFirstName">First Name</label>
              <input type="text" id="regFirstName" name="firstName"
                     placeholder="Alex" required>
            </div>
            <div class="field">
              <label for="regLastName">Last Name</label>
              <input type="text" id="regLastName" name="lastName"
                     placeholder="Smith">
            </div>
          </div>

          <div class="field">
            <label for="regEmail">Email Address</label>
            <input type="email" id="regEmail" name="email"
                   placeholder="you@example.com" required>
          </div>

          <div class="field">
            <label for="regPassword">Password</label>
            <input type="password" id="regPassword" name="password"
                   placeholder="Min. 6 characters" required minlength="6">
          </div>

          <!-- Provider-only bio field (shown/hidden by JS) -->
          <div class="field" id="bioField" style="display:none;">
            <label for="regBio">Bio (optional)</label>
            <textarea id="regBio" name="bio"
                      placeholder="Tell us about the circles you want to lead…"></textarea>
          </div>

          <button type="submit" class="submit-btn">Create Account →</button>
        </form>

        <p class="switch-link">
          Already have an account? <a onclick="showTab('login')">Sign in</a>
        </p>
      </div>

    </div>
  </div>
</div>

<footer>HobbyCircles &copy; 2026 &nbsp;·&nbsp; UNCG CSC 340</footer>

<script>
  // ── Tab switching
  function showTab(tab) {
    document.getElementById('loginForm').classList.toggle('active', tab === 'login');
    document.getElementById('registerForm').classList.toggle('active', tab === 'register');
    document.querySelectorAll('.tab-btn').forEach((btn, i) => {
      btn.classList.toggle('active', (tab === 'login' && i === 0) || (tab === 'register' && i === 1));
    });
  }

  // ── Role pill selection
  function selectRole(role, el) {
    document.querySelectorAll('.role-pill').forEach(p => p.classList.remove('selected'));
    el.classList.add('selected');
    document.getElementById('roleInput').value = role;
    document.getElementById('bioField').style.display = (role === 'PROVIDER') ? 'block' : 'none';
  }

  // ── If server redirected back to register tab (e.g., after error on register)
  const urlParams = new URLSearchParams(window.location.search);
  if (urlParams.get('tab') === 'register') showTab('register');
</script>
</body>
</html>

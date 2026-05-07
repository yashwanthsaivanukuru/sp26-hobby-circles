<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Profile – HobbyCircles</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --forest: #1a3a2a; --forest-mid: #2c5f3f; --forest-light: #3d7a54;
      --cream: #f7f2ea; --cream-dark: #ede5d4; --gold: #c9a84c;
      --text-dark: #1a1a1a; --text-mid: #4a4a4a; --text-light: #888;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); min-height: 100vh; }
    nav { background: var(--forest); padding: 0 48px; display: flex; align-items: center; height: 64px; box-shadow: 0 2px 20px rgba(0,0,0,0.2); }
    .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.4rem; color: var(--cream); text-decoration: none; }
    .nav-logo span { color: var(--gold); }
    .nav-back { margin-left: auto; color: rgba(247,242,234,0.7); text-decoration: none; font-size: 0.875rem; font-weight: 500; padding: 8px 16px; border-radius: 8px; transition: all 0.2s; }
    .nav-back:hover { background: rgba(255,255,255,0.08); color: var(--cream); }

    .page { display: flex; align-items: center; justify-content: center; padding: 56px 24px; }

    .card { background: white; border-radius: 20px; max-width: 500px; width: 100%; box-shadow: 0 4px 24px rgba(0,0,0,0.08); overflow: hidden; animation: fadeUp 0.5s ease both; }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }

    .card-top {
      background: linear-gradient(135deg, var(--forest-mid), var(--forest));
      padding: 36px 40px;
      position: relative;
      overflow: hidden;
    }
    .card-top::before {
      content: '';
      position: absolute;
      width: 200px; height: 200px;
      background: radial-gradient(circle, rgba(201,168,76,0.15), transparent 70%);
      top: -60px; right: -60px;
      border-radius: 50%;
    }
    .avatar {
      width: 64px; height: 64px;
      background: rgba(201,168,76,0.2);
      border: 2px solid var(--gold);
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.6rem;
      margin-bottom: 16px;
      position: relative;
    }
    .card-top h2 { font-family: 'Playfair Display', serif; font-size: 1.5rem; color: var(--cream); margin-bottom: 4px; }
    .card-top p { color: rgba(247,242,234,0.55); font-size: 0.85rem; font-weight: 300; position: relative; }

    .card-body { padding: 36px 40px; }

    .alert { padding: 11px 14px; border-radius: 8px; margin-bottom: 20px; font-size: 0.875rem; font-weight: 500; }
    .alert-error { background: #fdf0ef; color: #c0392b; border-left: 3px solid #c0392b; }
    .alert-success { background: #d8f3dc; color: #1b4332; border-left: 3px solid #27ae60; }

    .form-group { margin-bottom: 20px; }
    label { display: block; font-size: 0.78rem; font-weight: 600; color: var(--text-mid); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 7px; }
    input {
      width: 100%;
      padding: 12px 16px;
      border: 1.5px solid #e0e0e0;
      border-radius: 10px;
      font-size: 0.93rem;
      font-family: 'DM Sans', sans-serif;
      color: var(--text-dark);
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    input:focus { outline: none; border-color: var(--forest-light); box-shadow: 0 0 0 3px rgba(61,122,84,0.1); }

    .hint { font-size: 0.78rem; color: var(--text-light); margin-top: 5px; }

    .btn-submit {
      width: 100%;
      padding: 13px;
      background: var(--forest);
      color: var(--cream);
      border: none;
      border-radius: 10px;
      font-size: 0.95rem;
      font-weight: 600;
      cursor: pointer;
      font-family: 'DM Sans', sans-serif;
      transition: background 0.2s, transform 0.1s;
      margin-top: 4px;
    }
    .btn-submit:hover { background: var(--forest-mid); transform: translateY(-1px); }
    .btn-cancel { display: block; text-align: center; margin-top: 12px; color: var(--text-light); font-size: 0.875rem; text-decoration: none; }
    .btn-cancel:hover { color: var(--text-mid); }
  </style>
</head>
<body>
<nav>
  <a href="/search" class="nav-logo">Hobby<span>Circles</span></a>
  <a href="/hobbyist/dashboard" class="nav-back">← Dashboard</a>
</nav>

<div class="page">
  <div class="card">
    <div class="card-top">
      <div class="avatar">👤</div>
      <h2>Edit Profile</h2>
      <p>Update your account information</p>
    </div>
    <div class="card-body">
      <#if errorMessage??>
        <div class="alert alert-error">${errorMessage}</div>
      </#if>
      <#if successMessage??>
        <div class="alert alert-success">✓ ${successMessage}</div>
      </#if>

      <form action="/profile/update" method="post">
        <div class="form-group">
          <label>Email Address</label>
          <input type="email" name="email" value="${userEmail!''}" required>
        </div>
        <div class="form-group">
          <label>New Password</label>
          <input type="password" name="password" placeholder="Leave blank to keep current">
          <p class="hint">Only fill this in if you want to change your password</p>
        </div>
        <button type="submit" class="btn-submit">Save Changes →</button>
        <a href="/hobbyist/dashboard" class="btn-cancel">Cancel</a>
      </form>
    </div>
  </div>
</div>
</body>
</html>

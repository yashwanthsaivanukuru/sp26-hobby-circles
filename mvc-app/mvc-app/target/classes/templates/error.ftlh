<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error – HobbyCircles</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --forest: #1a3a2a; --forest-mid: #2c5f3f; --forest-light: #3d7a54;
      --cream: #f7f2ea; --gold: #c9a84c;
      --text-dark: #1a1a1a; --text-mid: #4a4a4a; --text-light: #888;
    }
    body { font-family: 'DM Sans', sans-serif; background: var(--cream); min-height: 100vh; display: flex; flex-direction: column; }
    nav { background: var(--forest); padding: 0 48px; display: flex; align-items: center; height: 64px; box-shadow: 0 2px 20px rgba(0,0,0,0.2); }
    .nav-logo { font-family: 'Playfair Display', serif; font-size: 1.4rem; color: var(--cream); text-decoration: none; }
    .nav-logo span { color: var(--gold); }

    .page { flex: 1; display: flex; align-items: center; justify-content: center; padding: 48px 24px; }
    .card {
      background: white; border-radius: 20px; padding: 56px 48px;
      text-align: center; max-width: 480px; width: 100%;
      box-shadow: 0 4px 24px rgba(0,0,0,0.08);
      animation: fadeUp 0.5s ease both;
    }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }

    .error-icon {
      width: 72px; height: 72px;
      background: #fdf0ef;
      border: 2px solid #e74c3c;
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.8rem;
      margin: 0 auto 24px;
    }
    h2 { font-family: 'Playfair Display', serif; font-size: 1.6rem; color: var(--text-dark); margin-bottom: 12px; }
    p { color: var(--text-light); font-size: 0.9rem; line-height: 1.6; margin-bottom: 32px; }

    .actions { display: flex; gap: 12px; justify-content: center; flex-wrap: wrap; }
    .btn-primary {
      padding: 11px 24px; background: var(--forest); color: var(--cream);
      border-radius: 10px; text-decoration: none; font-weight: 600; font-size: 0.875rem;
      transition: background 0.2s; cursor: pointer; border: none; font-family: 'DM Sans', sans-serif;
    }
    .btn-primary:hover { background: var(--forest-mid); }
    .btn-secondary {
      padding: 11px 24px; background: transparent; color: var(--text-mid);
      border: 1.5px solid #ddd; border-radius: 10px; text-decoration: none;
      font-weight: 500; font-size: 0.875rem; transition: border-color 0.2s;
    }
    .btn-secondary:hover { border-color: var(--forest-light); color: var(--forest); }
  </style>
</head>
<body>
<nav>
  <a href="/" class="nav-logo">Hobby<span>Circles</span></a>
</nav>
<div class="page">
  <div class="card">
    <div class="error-icon">⚠️</div>
    <h2>Something went wrong</h2>
    <p>${errorMessage!"An unexpected error occurred. Please try again."}</p>
    <div class="actions">
      <button class="btn-primary" onclick="history.back()">← Go Back</button>
      <a href="/" class="btn-secondary">Home</a>
    </div>
  </div>
</div>
</body>
</html>

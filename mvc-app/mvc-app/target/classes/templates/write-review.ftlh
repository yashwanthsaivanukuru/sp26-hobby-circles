<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Write a Review – HobbyCircles</title>
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
    .card { background: white; border-radius: 20px; padding: 48px; max-width: 560px; width: 100%; box-shadow: 0 4px 24px rgba(0,0,0,0.08); animation: fadeUp 0.5s ease both; }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }

    .circle-pill {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: rgba(61,122,84,0.08);
      color: var(--forest-mid);
      padding: 6px 14px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
      margin-bottom: 20px;
    }

    h2 { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: var(--forest); margin-bottom: 6px; }
    .subtitle { color: var(--text-light); font-size: 0.875rem; margin-bottom: 36px; }

    /* Star rating */
    .rating-group { margin-bottom: 28px; }
    label { display: block; font-size: 0.78rem; font-weight: 600; color: var(--text-mid); text-transform: uppercase; letter-spacing: 0.06em; margin-bottom: 12px; }

    .stars { display: flex; gap: 8px; flex-direction: row-reverse; justify-content: flex-end; }
    .stars input { display: none; }
    .stars label {
      font-size: 2rem;
      cursor: pointer;
      color: #ddd;
      transition: color 0.15s;
      text-transform: none;
      letter-spacing: 0;
      font-size: 2rem;
      padding: 0;
      margin: 0;
    }
    .stars input:checked ~ label,
    .stars label:hover,
    .stars label:hover ~ label { color: var(--gold); }

    .form-group { margin-bottom: 24px; }
    textarea {
      width: 100%;
      padding: 14px 16px;
      border: 1.5px solid #e0e0e0;
      border-radius: 10px;
      font-size: 0.93rem;
      font-family: 'DM Sans', sans-serif;
      color: var(--text-dark);
      resize: vertical;
      min-height: 130px;
      transition: border-color 0.2s, box-shadow 0.2s;
    }
    textarea:focus { outline: none; border-color: var(--forest-light); box-shadow: 0 0 0 3px rgba(61,122,84,0.1); }

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
    }
    .btn-submit:hover { background: var(--forest-mid); transform: translateY(-1px); }
    .btn-cancel { display: block; text-align: center; margin-top: 12px; color: var(--text-light); font-size: 0.875rem; text-decoration: none; }
    .btn-cancel:hover { color: var(--text-mid); }
  </style>
</head>
<body>
<nav>
  <a href="/search" class="nav-logo">Hobby<span>Circles</span></a>
  <a href="/search" class="nav-back">← Back to Circles</a>
</nav>

<div class="page">
  <div class="card">
    <#if circle??>
      <div class="circle-pill">🌿 ${circle.name}</div>
    </#if>
    <h2>Share Your Experience</h2>
    <p class="subtitle">Help others discover great hobby circles with your honest review</p>

    <form action="/review/submit" method="post">
      <input type="hidden" name="circleId" value="${circle.circleId!''}">

      <div class="rating-group">
        <label>Your Rating</label>
        <div class="stars">
          <input type="radio" name="rating" id="s5" value="5" required><label for="s5">★</label>
          <input type="radio" name="rating" id="s4" value="4"><label for="s4">★</label>
          <input type="radio" name="rating" id="s3" value="3"><label for="s3">★</label>
          <input type="radio" name="rating" id="s2" value="2"><label for="s2">★</label>
          <input type="radio" name="rating" id="s1" value="1"><label for="s1">★</label>
        </div>
      </div>

      <div class="form-group">
        <label>Your Review</label>
        <textarea name="comment" placeholder="What did you enjoy most? What would you tell someone considering joining?" required></textarea>
      </div>

      <button type="submit" class="btn-submit">Submit Review →</button>
      <a href="/search" class="btn-cancel">Cancel</a>
    </form>
  </div>
</div>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Statistics | HobbyCircles</title>
  <link rel="stylesheet" href="/style.css">
</head>
<body>

  <header>
    <h1>HobbyCircles</h1>
    <nav>
      <a href="/providers/${provider.userId?c}">Dashboard</a>
      <a href="/providers/${provider.userId?c}/circle">My Circle</a>
      <a href="/providers/${provider.userId?c}/reviews">Reviews</a>
      <a href="/providers/${provider.userId?c}/statistics">Statistics</a>
    </nav>
  </header>

  <main class="container">
    <h2>Circle Statistics</h2>

    <#if circle??>
      <p class="subtitle">Overview for <strong>${circle.name}</strong></p>

      <div class="stats-grid">

        <div class="stat-card">
          <div class="stat-number">${memberCount}</div>
          <div class="stat-label">Total Memberships</div>
        </div>

        <div class="stat-card">
          <div class="stat-number">${upcomingCount}</div>
          <div class="stat-label">Events Scheduled</div>
        </div>

        <div class="stat-card">
          <div class="stat-number">${avgRating}</div>
          <div class="stat-label">Average Rating / 5</div>
        </div>

        <div class="stat-card">
          <div class="stat-number">${reviewCount}</div>
          <div class="stat-label">Total Reviews</div>
        </div>

      </div>

      <div class="info-card" style="margin-top: 30px;">
        <h3>Circle Info</h3>
        <p><strong>Category:</strong> ${circle.category!""}</p>
        <p><strong>City:</strong> ${circle.city!""}</p>
        <p><strong>Created:</strong> ${circle.createdAt}</p>
        <p><strong>Last Updated:</strong> ${circle.updatedAt}</p>
      </div>

    <#else>
      <div class="info-card warning">
        <p>No circle found. <a href="/providers/${provider.userId?c}/circle">Create your circle</a> to see statistics.</p>
      </div>
    </#if>

    <a href="/providers/${provider.userId?c}" class="btn btn-secondary" style="margin-top: 20px;">Back to Dashboard</a>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>

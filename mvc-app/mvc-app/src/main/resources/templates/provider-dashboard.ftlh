<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Provider Dashboard | HobbyCircles</title>
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
    <h2>Welcome, ${provider.email}!</h2>
    <p class="subtitle">Manage your hobby circle from this dashboard.</p>

    <#if circle??>
      <div class="info-card">
        <h3>Your Circle: ${circle.name}</h3>
        <p><strong>Category:</strong> ${circle.category!""}</p>
        <p><strong>City:</strong> ${circle.city!""}</p>
        <p><strong>Description:</strong> ${circle.description!""}</p>
        <p class="muted">Created: ${circle.createdAt}</p>
      </div>
    <#else>
      <div class="info-card warning">
        <p>You have not created a circle yet.</p>
        <a href="/providers/${provider.userId?c}/circle" class="btn">Create Your Circle</a>
      </div>
    </#if>

    <div class="menu-grid">
      <a href="/providers/${provider.userId?c}/circle" class="menu-card">
        <h3>&#9998; Create / Edit Circle</h3>
        <p>Set up or update your circle's name, category, and description.</p>
      </a>
      <a href="/providers/${provider.userId?c}/reviews" class="menu-card">
        <h3>&#9733; Manage Reviews</h3>
        <p>Read member feedback and reply to reviews.</p>
      </a>
      <a href="/providers/${provider.userId?c}/statistics" class="menu-card">
        <h3>&#128202; View Statistics</h3>
        <p>See your member count, events, and average rating.</p>
      </a>
      <a href="/providers/${provider.userId?c}/events/new" class="menu-card">
        <h3>&#128197; Schedule Meetup</h3>
        <p>Create a new event for your circle members.</p>
      </a>
      <a href="/providers/${provider.userId?c}/events" class="menu-card">
        <h3>&#128506; View Events</h3>
        <p>See all scheduled events for your circle.</p>
      </a>
    </div>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>

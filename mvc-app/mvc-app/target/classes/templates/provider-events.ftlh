<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Events | HobbyCircles</title>
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
    <h2>Scheduled Events</h2>

    <#if circle??>
      <p class="subtitle">Events for <strong>${circle.name}</strong></p>
    </#if>

    <a href="/providers/${provider.userId?c}/events/new" class="btn" style="margin-bottom: 24px;">
      + Schedule New Event
    </a>

    <#if events?has_content>
      <#list events as event>
        <div class="info-card">
          <h3>${event.title}</h3>
          <p><strong>Location:</strong> ${event.location!""}</p>
          <p><strong>Date:</strong> ${event.eventDate}</p>
          <p><strong>Status:</strong> ${event.status!""}</p>
          <p><strong>Description:</strong> ${event.description!""}</p>
        </div>
      </#list>
    <#else>
      <div class="info-card">
        <p>No events scheduled yet. Click the button above to create your first event!</p>
      </div>
    </#if>

    <a href="/providers/${provider.userId?c}" class="btn btn-secondary" style="margin-top: 20px;">
      Back to Dashboard
    </a>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>
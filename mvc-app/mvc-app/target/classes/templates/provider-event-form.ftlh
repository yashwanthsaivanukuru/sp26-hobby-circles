<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Schedule Event | HobbyCircles</title>
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
    <h2>Schedule a Meetup</h2>
    <p class="subtitle">Create a new event for <strong>${circle.name}</strong></p>

    <form class="form-box" action="/providers/${provider.userId?c}/events/save" method="post">

      <label for="title">Event Title</label>
      <input type="text" id="title" name="title"
             placeholder="e.g. Weekly Hike at Piedmont Park" required>

      <label for="location">Location</label>
      <input type="text" id="location" name="location"
             placeholder="e.g. Piedmont Park, Atlanta" required>

      <label for="eventDate">Date and Time</label>
      <input type="datetime-local" id="eventDate" name="eventDate" required>

      <label for="description">Description</label>
      <textarea id="description" name="description" rows="4"
                placeholder="Describe what you will be doing..."></textarea>

      <button type="submit" class="btn">Schedule Event</button>
      <a href="/providers/${provider.userId?c}" class="btn btn-secondary">Back to Dashboard</a>
    </form>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>
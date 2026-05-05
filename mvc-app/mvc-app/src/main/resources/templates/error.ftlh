<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Error | HobbyCircles</title>
  <link rel="stylesheet" href="/style.css">
</head>
<body>

  <header>
    <h1>HobbyCircles</h1>
    <nav>
      <a href="/">Home</a>
    </nav>
  </header>

  <main class="container">
    <div class="info-card warning" style="text-align:center; margin-top: 60px;">
      <h2>Something went wrong</h2>
      <p>${errorMessage!"An unexpected error occurred."}</p>
      <a href="javascript:history.back()" class="btn btn-secondary" style="margin-top:15px;">Go Back</a>
    </div>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>

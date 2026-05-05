<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create / Edit Circle | HobbyCircles</title>
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
    <h2>Create / Edit Circle</h2>
    <p class="subtitle">Fill in the details below to save your circle.</p>

    <!--
      action maps to @PostMapping("/{id}/circle/save") in ProviderMvcController.
      Input names must match Circle field names exactly for Spring to bind them.
    -->
    <form class="form-box" action="/providers/${provider.userId?c}/circle/save" method="post">

      <!-- Hidden field: carries the circleId so Spring knows this is an update, not a new circle -->
      <#if circle.circleId??>
        <input type="hidden" name="circleId" value="${circle.circleId?c}">
      </#if>

      <label for="name">Circle Name</label>
      <input type="text" id="name" name="name"
             placeholder="Enter circle name"
             value="${circle.name!""}" required>

      <label for="city">City</label>
      <input type="text" id="city" name="city"
             placeholder="e.g. Charlotte, Raleigh"
             value="${circle.city!""}" required>

      <label for="category">Category</label>
      <input type="text" id="category" name="category"
             placeholder="e.g. Sports, Gaming, Art"
             value="${circle.category!""}">

      <label for="description">Description</label>
      <textarea id="description" name="description"
                rows="4"
                placeholder="Describe your group and what you do together">${circle.description!""}</textarea>

      <button type="submit" class="btn">Save Circle</button>
      <a href="/providers/${provider.userId?c}" class="btn btn-secondary">Back to Dashboard</a>
    </form>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>

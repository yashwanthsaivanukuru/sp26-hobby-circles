<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Manage Reviews | HobbyCircles</title>
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
    <h2>Manage Reviews</h2>

    <#if circle??>
      <p class="subtitle">Reviews for <strong>${circle.name}</strong> &mdash; Average Rating: <strong>${avgRating} / 5</strong></p>
    <#else>
      <p class="subtitle warning">You have no circle yet. <a href="/providers/${provider.userId?c}/circle">Create one first.</a></p>
    </#if>

    <#if reviews?has_content>
      <#list reviews as review>
        <div class="review-card">

          <!-- Star display -->
          <div class="stars">
            <#list 1..5 as i>
              <#if i <= review.rating>&#9733;<#else>&#9734;</#if>
            </#list>
            <span class="rating-label">${review.rating} / 5</span>
          </div>

          <!-- Review comment -->
          <p class="review-comment">"${review.comment!""}"</p>
          <p class="muted">Review #${review.reviewId?c}</p>

          <!-- Existing reply -->
          <#if review.replyText?has_content>
            <div class="existing-reply">
              <strong>Your Reply:</strong>
              <p>${review.replyText}</p>
            </div>
          </#if>

          <!-- Reply form -->
          <!--
            action maps to @PostMapping("/{id}/reviews/{reviewId}/reply") in ProviderMvcController.
          -->
          <form class="reply-form" action="/providers/${provider.userId?c}/reviews/${review.reviewId?c}/reply" method="post">
            <label for="reply-${review.reviewId?c}">
              <#if review.replyText?has_content>Update Reply:<#else>Write a Reply:</#if>
            </label>
            <textarea id="reply-${review.reviewId?c}" name="replyText" rows="3"
                      placeholder="Write your response...">${review.replyText!""}</textarea>
            <button type="submit" class="btn">Submit Reply</button>
          </form>

        </div>
      </#list>
    <#else>
      <div class="info-card">
        <p>No reviews yet. Reviews will appear here once members submit them.</p>
      </div>
    </#if>

    <a href="/providers/${provider.userId?c}" class="btn btn-secondary" style="margin-top:20px;">Back to Dashboard</a>
  </main>

  <footer>
    <p>HobbyCircles &copy; 2026</p>
  </footer>

</body>
</html>

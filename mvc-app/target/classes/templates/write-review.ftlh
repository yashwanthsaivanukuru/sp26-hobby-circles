<!DOCTYPE html>
<html>
<head>
    <title>Write a Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-5">
    <div class="container mt-5">
        <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
            <h3>Review Circle #${circleId}</h3>
            <form action="/review/submit" method="post">
                <input type="hidden" name="circleId"   value="${circleId}">
                <input type="hidden" name="hobbyistId" value="${hobbyistId!0}">

                <div class="mb-3">
                    <label class="form-label">Rating (1-5)</label>
                    <select name="rating" class="form-select">
                        <option value="5">5 - Excellent</option>
                        <option value="4">4 - Very Good</option>
                        <option value="3">3 - Average</option>
                        <option value="2">2 - Poor</option>
                        <option value="1">1 - Terrible</option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">Comment</label>
                    <textarea name="comment" class="form-control" rows="4"
                              placeholder="Share your experience..." required></textarea>
                </div>

                <button type="submit" class="btn btn-success w-100">Post Review</button>
                <a href="/search" class="btn btn-link w-100">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>

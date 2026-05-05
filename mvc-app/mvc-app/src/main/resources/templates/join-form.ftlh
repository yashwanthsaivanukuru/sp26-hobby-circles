<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Circle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .card { border-radius: 15px; border: none; }
    </style>
</head>
<body class="p-5">
    <div class="container mt-5">
        <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
            <div class="text-center mb-4">
                <h3 class="fw-bold">Join Hobby Circle</h3>
                <p class="text-muted">Fill out the details below to apply.</p>
            </div>

            <form action="/join/submit" method="post">
                <input type="hidden" name="circleId" value="${circleId}">
                
                <div class="mb-3">
                    <label class="form-label fw-semibold">Full Name</label>
                    <input type="text" name="userName" class="form-control" placeholder="John Doe" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label fw-semibold">Phone Number</label>
                    <input type="tel" name="phone" class="form-control" placeholder="(555) 555-5555" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Email Address</label>
                    <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-semibold">Why do you want to join?</label>
                    <textarea name="reason" class="form-control" rows="3" placeholder="Tell us a bit about your interest..." required></textarea>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-success btn-lg">Submit Registration</button>
                    <a href="/search" class="btn btn-outline-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
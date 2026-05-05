<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light p-5">
    <div class="container mt-5">
        <div class="card shadow p-4 mx-auto" style="max-width: 500px;">
            <h3>Update Your Profile</h3>
            <form action="/profile/update" method="post">
                <input type="hidden" name="id" value="${hobbyist.id!''}">
                
                <div class="mb-3">
                    <label class="form-label">First Name</label>
                    <input type="text" name="firstName" class="form-control" value="${hobbyist.firstName!''}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Last Name</label>
                    <input type="text" name="lastName" class="form-control" value="${hobbyist.lastName!''}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="${hobbyist.email!''}" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" value="${hobbyist.password!''}" required>
                </div>

                <button type="submit" class="btn btn-primary w-100">Save Changes</button>
                <a href="/search" class="btn btn-link w-100">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>
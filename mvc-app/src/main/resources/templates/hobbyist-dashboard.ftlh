<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hobbyist Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; }
        .nav-sidebar { background: #2c3e50; min-height: 100vh; color: white; }
        .nav-sidebar a { color: #bdc3c7; text-decoration: none; display: block; padding: 15px; }
        .nav-sidebar a:hover { background: #34495e; color: white; }
        .active-link { background: #1abc9c; color: white !important; }
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <!-- Sidebar Navigation -->
        <nav class="col-md-2 nav-sidebar p-0">
            <div class="p-4 text-center">
                <h4>HobbyCircles</h4>
                <p class="small text-muted">Hobbyist Portal</p>
            </div>
            <a href="/hobbyist/dashboard?email=${userEmail!''}" class="active-link">📋 My Circles</a>
            <a href="/search">🔍 Find New Circles</a>
            <a href="/profile/edit/1">👤 Edit Profile</a>
        </nav>

        <!-- Main Content -->
        <main class="col-md-10 p-5">
            <h2 class="mb-4">Welcome Back!</h2>
            
            <div class="card shadow border-0 p-4">
                <h5 class="fw-bold mb-3">Your Active Memberships</h5>
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Registration Ref</th>
                                <th>Circle ID</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <#if memberships?? && (memberships?size > 0)>
                                <#list memberships as reg>
                                    <tr>
                                        <td>#REG-${reg.id}</td>
                                        <td><strong>Circle ${reg.circleId}</strong></td>
                                        <td><span class="badge bg-success">Active</span></td>
                                        <td>
                                            <a href="/review/${reg.circleId}" class="btn btn-sm btn-outline-warning">⭐ Write Review</a>
                                        </td>
                                    </tr>
                                </#list>
                            <#else>
                                <tr>
                                    <td colspan="4" class="text-center py-5 text-muted">
                                        You haven't joined any circles yet.<br>
                                        <a href="/search" class="btn btn-primary mt-3">Browse Circles</a>
                                    </td>
                                </tr>
                            </#if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
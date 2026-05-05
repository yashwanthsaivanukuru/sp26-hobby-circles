<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Membership Confirmed</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .success-card { border-top: 5px solid #198754; }
        .btn-review { font-weight: 600; font-size: 0.85rem; }
    </style>
</head>
<body class="p-5">
    <div class="container">
        <!-- Main Success Message -->
        <div class="card shadow success-card p-5 text-center mb-4">
            <h1 class="display-5 text-success">Registration Successful!</h1>
            <p class="lead">Welcome to the community, <strong>${name!"User"}</strong>.</p>
            <p class="text-muted">Your application has been processed and your membership is now active.</p>
            <div class="mt-4">
                <a href="/search" class="btn btn-primary btn-lg">Explore More Circles</a>
            </div>
        </div>

        <!-- Dashboard View (The Membership Proof) -->
        <div class="card shadow p-4">
            <h4 class="mb-4 fw-bold">My Active Memberships</h4>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Reference ID</th>
                            <th>Circle Name/ID</th>
                            <th>Registered Email</th>
                            <th>Status & Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <#if memberships?? && (memberships?size > 0)>
                            <#list memberships as reg>
                                <tr>
                                    <td class="text-monospace">#REG-${reg.id}</td>
                                    <td>Circle ${reg.circleId}</td>
                                    <td>${reg.email}</td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <span class="badge rounded-pill bg-success">Active Member</span>
                                            
                                            <!-- USE-CASE 4: WRITE REVIEW (Contextual) -->
                                            <!-- Moved here because you can only review circles you have joined -->
                                            <a href="/review/${reg.circleId}" class="btn btn-outline-warning btn-review btn-sm">
                                                ⭐ Write Review
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </#list>
                        <#else>
                            <tr>
                                <td colspan="4" class="text-center py-4 text-muted">No active memberships found.</td>
                            </tr>
                        </#if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
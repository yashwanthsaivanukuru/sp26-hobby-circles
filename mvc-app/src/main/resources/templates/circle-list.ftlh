<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hobby Circles Explorer</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', sans-serif; }
        .navbar { background-color: #2c3e50 !important; margin-bottom: 40px; }
        .search-container { background: white; padding: 30px; border-radius: 15px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); margin-bottom: 40px; }
        .circle-card { background: white; border: none; border-radius: 12px; transition: transform 0.2s; box-shadow: 0 4px 6px rgba(0,0,0,0.07); }
        .circle-card:hover { transform: translateY(-5px); box-shadow: 0 8px 15px rgba(0,0,0,0.1); }
        .btn-join { background-color: #27ae60; color: white; border-radius: 8px; font-weight: 600; text-decoration: none; }
        .btn-join:hover { background-color: #219150; color: white; }
        .location-badge { background-color: #e8f4fd; color: #2980b9; padding: 5px 12px; border-radius: 20px; font-size: 0.85rem; }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
    <div class="container">
        <a href="/search" style="text-decoration: none;"><span class="navbar-brand mb-0 h1">🌐 Hobby Circles</span></a>
        
        <div class="navbar-nav ms-auto">
            <!-- UPDATED: Links to the Hobbyist Dashboard for demonstration -->
            <!-- Using your email as the parameter to simulate a logged-in state -->
            <a class="nav-link btn btn-outline-light px-3" href="/hobbyist/dashboard?email=vanukuruyaswanth@gmail.com">
                📊 My Dashboard
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">

            <#-- Displays messages from RedirectAttributes -->
            <#if message??>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </#if>

            <#if successMessage??>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </#if>
            
            <div class="search-container text-center">
                <h2 class="mb-4">Find Your Community</h2>
                <form action="/search" method="get" class="d-flex gap-2">
                    <input type="text" name="query" class="form-control form-control-lg" placeholder="Search hobbies or cities...">
                    <button type="submit" class="btn btn-primary btn-lg px-4">Search</button>
                </form>
            </div>

            <h4 class="mb-3">Available Circles (${circles?size})</h4>
            
            <#list circles as circle>
                <div class="card circle-card mb-3">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h5 class="card-title mb-1">${circle.name}</h5>
                            <p class="card-text text-muted mb-2">${circle.description!""}</p>
                            <span class="location-badge">📍 ${circle.city!"Local"}</span>
                        </div>
                        
                        <div class="d-flex flex-column gap-2">
                            <!-- USE-CASE 2: JOIN -->
                            <a href="/join/${circle.id}" class="btn btn-join px-4">Join Circle</a>
                        </div>
                    </div>
                </div>
            <#else>
                <div class="alert alert-info">No circles found. Try another search!</div>
            </#list>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
Requirements – HobbyCircles

Project Name: HobbyCircles
Team: Pranav B. – Provider; Yashwanth Vanukuru– Customer;
Course: CSC 340
Version: 1.0
Date: 2-13-2026
Purpose: This SRS defines the scope and user-facing requirements of HobbyCircles and the user stories that guide development and testing.

1. Overview

HobbyCircles is a web-based community platform that helps individuals discover and join hobby-based social groups in a new city. Users can browse Circles, subscribe to groups aligned with their interests, view meetup calendars, RSVP to events, and leave reviews. Group creators manage Circle pages, schedule meetups, and engage with members, while administrators ensure safety and appropriate use of the platform.

Glossary

Circle: A hobby-based community group created by a provider.
Hobbyist: A user who joins Circles and participates in events.
Provider: A group creator or leader who manages a Circle.
Meetup: A scheduled event organized by a Circle.
Subscription: A hobbyist joining a Circle.
Review: Feedback left by a hobbyist about a Circle or meetup.
Engagement: Metrics such as member count, RSVPs, and reviews.

Primary Users / Roles

Customer (Hobbyist) — Discover Circles, join communities, attend meetups, and provide feedback.
Provider (Group Creator) — Create and manage Circles, schedule meetups, and monitor participation.

Scope (this semester)

<User registration and authentication>
<Hobbyist profile creation with interest selection>
<Circle creation and management>
<Meetup scheduling and calendar viewing>
<Subscription joining Circles>
<Review system with provider responses>

Out of Scope (deferred)

<Real-time chat or messaging system>
<Mobile application>
<Paid events or payment processing>
<Advanced recommendation algorithms>

2. Functional Requirements 
2.1 Customer (Hobbyist) Stories
US-CUST-001 — Register & manage profile

Story:
As a hobbyist, I want to create and update my profile with personal interests and preferences so that I can discover relevant Circles.

Acceptance:

Scenario: Create profile with interests
  Given <I am a registered user>
  When <I select interests and save my profile>
  Then <the system stores my preferences and recommended Circles are displayed>

US-CUST-002 — Browse Circles

Story:
As a hobbyist, I want to browse available Circles by category and location so that I can find groups that match my interests.

Acceptance:

Scenario: View Circle listings given multiple Circles exist
  When <I open the Browse page>
  Then <I see a list of Circles with name, description, and category>

US-CUST-003 — Subscribe to a Circle

Story:
As a hobbyist, I want to join a Circle so that I can access its meetup calendar and events.

Acceptance:

Scenario: Join Circle successfully
  Given <I am viewing a Circle page>
  When <I click "Join Circle">
  Then <I become a member and the Circle calendar becomes visible>

US-CUST-004 — RSVP to Meetup

Story:
As a hobbyist, I want to RSVP to upcoming meetups so that organizers know how many people will attend.

Acceptance:

Scenario: RSVP to event
  Given <I am a member of a Circle>
  When <I select a meetup and click RSVP>
  Then <my attendance is recorded and the attendee count increases>

US-CUST-005 — Write a review

Story:
As a hobbyist, I want to leave a review for a Circle I joined so that I can share my experience with others.

Acceptance:

Scenario: Submit review
  Given <I am a member of the Circle>
  When <I submit a rating and comment>
  Then <the review is recorded and displayed on the Circle page>

US-CUST-006 — Read reviews

Story:
As a hobbyist, I want to read reviews from other members so that I can evaluate the quality of a Circle.

Acceptance:

Scenario: View reviews
  Given <reviews exist for a Circle>
  When <I open the Reviews section>
  Then <I see recent reviews with ratings and comments>

2.2 Provider (Group Creator) Stories
US-PROV-001 — Register & manage provider profile

Story:
As a provider, I want to create and update my profile so that users can learn about me and my Circle.

Acceptance:

Scenario: Update provider profile
  Given <I am a verified provider>
  When <I edit my profile information>
  Then <the updated details are saved and visible>

US-PROV-002 — Create a Circle

Story:
As a provider, I want to create a Circle page with details about the group so that hobbyists can discover it.

Acceptance:

Scenario: Create Circle
  Given <my provider profile is active>
  When <I submit Circle name, description, and category>
  Then <the Circle is created and appears in search results>

US-PROV-003 — Schedule meetups

Story:
As a provider, I want to post meetup events with date and location so that members know when to gather.

Acceptance:

Scenario: Create meetup
  Given <I manage a Circle>
  When <I add a new event with date, time, and location>
  Then <the meetup appears on the Circle calendar>

US-PROV-004 — View member statistics

Story:
As a provider, I want to view participation statistics so that I can evaluate engagement.

Acceptance:

Scenario: View analytics
  Given <I access the provider dashboard>
  When <I select my Circle>
  Then <I see member count and RSVP totals>

US-PROV-005 — Reply to reviews

Story:
As a provider, I want to respond to reviews so that I can engage with members and address feedback.

Acceptance:

Scenario: Respond to review
  Given <a review exists>
  When <I submit a reply>
  Then <the reply appears publicly beneath the review>

3. Non-Functional Requirements

Performance: 95% of pages load within ≤ 2 seconds under normal usage.
Availability/Reliability: ≥ 99% uptime during the semester period.
Security/Privacy: Passwords stored using hashing; role-based access control enforced.
Usability: New users should be able to join a Circle within ≤ 3 minutes of first use.

4. Assumptions, Constraints, and Policies

Users access the platform via modern web browsers.
Reliable internet connection is required.
Content must follow community guidelines.
Only members may review a Circle.

5. Milestones 

M2 Requirements — this SRS + stories opened as issues.
M3 High-fidelity prototype — core hobbyist/provider flows interactive.
M4 Design — architecture, schema, API outline.
M5 Backend API — key endpoints + tests.
M6 Increment — ≥2 use cases end-to-end.
M7 Final — complete system & documentation.

6. Change Management

Stories are living artifacts tracked via repository issues and pull requests.
Significant scope changes require team approval and SRS updates.
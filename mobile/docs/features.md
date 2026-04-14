# Features — What's Built & What's Todo

## ✅ Done

### Auth
- Email OTP login (dev: any email + `123456`)
- Account type toggle: Therapist / Looking for help
- Silent token refresh on app start (separate paths per account type)
- Sign out (invalidates refresh token)

### Therapist Onboarding
- Multi-step form: personal info → credentials → sessions + location
- Address with state/nation (used for geo-filtered discovery)
- Upload: profile photo, degree certificate, government ID

### Therapist Status Pages
- `pending` — waiting for admin approval
- `rejected` — shows rejection reason

### Therapist Home + Blog
- Home page (verified therapists)
- Blog: create/edit/publish/delete drafts, list published, like toggle
- Blog detail with view count increment
- Image upload per blog

### User Onboarding
- Fields: name, phone, state, nation
- "Looking for help" multi-select (30 categories)

### Therapist Discovery (User)
- Recommendations: location-scored (same state=2, same nation=1, else=0) + rating
- Search: ILIKE on name / bio / specializations + optional session-type filter
- Filter chips: All / Video / In-person
- Infinite scroll pagination
- Therapist profile page: photo, bio, specializations, fee, location, book CTA

---

## 🔲 Todo

### Booking
- [ ] Book a session flow (date/time picker → backend booking table)
- [ ] Therapist calendar / availability management

### Messaging
- [ ] In-app chat between user and therapist

### Ratings & Reviews
- [ ] User rates session → updates therapist `rating` + `total_sessions`

### Therapist Profile (public edit)
- [ ] Therapist can update bio, photo, fee, session types post-onboarding

### Notifications
- [ ] Push notifications (booking confirmations, session reminders)

### Admin Panel
- [ ] Web admin to approve/reject therapists (currently CLI/direct DB)

### Payments
- [ ] Session fee collection (Razorpay / Stripe)

---

## Data Flow: Discovery

```
UserHomePage (init)
  └─ UserProfileCubit.load(userId)       ← GetUserProfile RPC
        ↓ profile.state, profile.nation
  └─ DiscoveryBloc ← DiscoveryRecommendationsRequested(state, nation)
        ↓ DiscoveryRepository.getRecommendedTherapists()
        ↓ GetRecommendedTherapists RPC
        ↓ DiscoveryLoaded(therapists)
  └─ ListView → TherapistCard
        onTap → push('/user/therapist', extra: TherapistCardModel)
              → TherapistProfilePage

Search typed (400ms debounce)
  └─ DiscoveryBloc ← DiscoverySearchChanged(query, sessionType)
        ↓ SearchTherapists RPC (ILIKE + optional session_type filter)
        ↓ DiscoveryLoaded(therapists, isSearch: true, total)

Scroll to bottom
  └─ DiscoveryBloc ← DiscoveryLoadMoreRequested
        ↓ next page appended to existing list
```

## Data Flow: Blog (Therapist)

```
BlogListPage
  └─ BlogBloc ← BlogListRequested / MyBlogListRequested
BlogDetailPage
  └─ BlogBloc ← BlogDetailRequested (increments views)
CreateBlogPage
  └─ BlogBloc ← BlogSubmitted (create or update)
               ← BlogPublishRequested
               ← BlogImageUploadRequested
```

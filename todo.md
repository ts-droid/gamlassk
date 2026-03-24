# Gamla SSK Website - TODO

## Design & Styling
- [x] Implement color scheme (navy blue, yellow/gold, blue, white)
- [x] Create header with navy blue background
- [x] Add Gamla SSK logo/emblem
- [x] Ensure responsive design for mobile and desktop

## Database Schema
- [x] Create news table (id, title, content, image, createdAt, publishedAt)
- [x] Create membership_applications table (id, name, email, phone, message, createdAt, status)
- [x] Run database migrations

## Backend API
- [x] Create API endpoint for fetching latest 3 news articles (GET /api/news/latest)
- [x] Create API endpoint for fetching all news (GET /api/news)
- [x] Create API endpoint for creating news (POST /api/news) - admin only
- [x] Create API endpoint for updating news (PUT /api/news/:id) - admin only
- [x] Create API endpoint for deleting news (DELETE /api/news/:id) - admin only
- [x] Create API endpoint for membership applications (POST /api/membership)
- [x] Create API endpoint for viewing membership applications (GET /api/membership) - admin only

## Admin Interface
- [x] Create admin dashboard page
- [x] Build news management interface (list, create, edit, delete)
- [ ] Add rich text editor for news content
- [ ] Add image upload for news articles
- [x] Create membership applications view for admins
- [x] Implement admin authentication/authorization

## Frontend Pages
- [x] Create homepage with hero section explaining who Gamla SSK is
- [x] Add about section with history (founded 1937)
- [x] Display news feed showing 3 latest news articles
- [x] Create banner section for folkspels-bingolotter promotion
- [x] Create banner section for membership call-to-action
- [x] Add membership application form
- [x] Create page/section with links to statutes (stadgar)
- [x] Add contact information section with board members
- [x] Create footer with social media links

## Testing & Deployment
- [x] Test all API endpoints
- [x] Test admin interface functionality
- [x] Test membership application form
- [x] Test responsive design on different devices
- [x] Create checkpoint for deployment

## Authentication & User Management
- [x] Extend user schema with member information (phone, address, membership status)
- [x] Create API endpoints for member profile management
- [x] Implement login/logout functionality
- [x] Add role-based access control (admin vs member)
- [x] Research BankID integration for Swedish authentication

## Member Profile ("Min sida")
- [x] Create "Min sida" page for logged-in members
- [x] Add form to update personal information (name, email, phone, address)
- [x] Display membership status
- [x] Add profile update API endpoint

## Admin Dashboard
- [x] Create admin dashboard layout
- [x] Add admin navigation menu
- [x] Create news management page (list, create, edit, delete)
- [ ] Add rich text editor for news content
- [x] Create membership applications management page
- [x] Add ability to approve/reject membership applications


## Enhancements - Phase 2

### Image Upload
- [x] Add image upload component to news management
- [x] Implement S3 upload functionality for images
- [x] Update news creation/editing to support file uploads
- [x] Display uploaded images in news preview

### Rich Text Editor
- [x] Install and configure Tiptap editor
- [x] Integrate Tiptap into news creation form
- [x] Integrate Tiptap into news editing form
- [x] Update news display to render formatted HTML content

### Statutes Page
- [x] Create statutes/bylaws page route
- [x] Add statutes content with organizational structure
- [x] Add history section with timeline
- [x] Add board member information
- [x] Link statutes page from footer and navigation


## Role-Based Access Control (RBAC)

### Database Schema
- [x] Create roles table (id, name, description, permissions JSON)
- [x] Update users table to include roleId foreign key
- [x] Create predefined roles: huvudadmin, nyhetsadmin, medlemsadmin
- [x] Run database migrations

### Backend API
- [x] Create role management endpoints (CRUD for roles)
- [x] Create permission management endpoints
- [x] Create user role assignment endpoints
- [x] Add role-based middleware for protected routes
- [x] Update news endpoints with role checks (nyhetsadmin, huvudadmin)
- [x] Update membership endpoints with role checks (medlemsadmin, huvudadmin)

**Implementation details:**
- Created `userHasPermission()` and `getUserRole()` helper functions in db.ts
- Added `requirePermission()` middleware factory in trpc.ts
- Created convenience procedures: manageNewsProcedure, manageMembersProcedure, manageRolesProcedure, manageUsersProcedure, manageCMSProcedure
- Updated all news endpoints to use manageNewsProcedure
- Updated all membership endpoints to use manageMembersProcedure
- Users with manage_all permission (huvudadmin) automatically get access to all endpoints

### Admin UI
- [x] Remove Admin button from header (keep only /admin direct link)
- [x] Create role management page for huvudadmin
- [x] Create user management page to assign roles
- [x] Create custom role creation interface
- [x] Add permission checkboxes for custom roles
- [x] Update admin dashboard to show role-specific options
- [x] Add member list view for medlemsadmin
- [x] Restrict news management to nyhetsadmin and huvudadmin
- [x] Show/hide UI elements based on user role

### Permissions System
- [x] Define permission types (manage_news, manage_members, manage_roles, manage_users, view_members)
- [x] Implement permission checking in frontend
- [x] Implement permission checking in backend


## Photo Gallery

### Database & Backend
- [x] Create gallery_photos table (id, title, description, imageUrl, category, uploadedBy, createdAt)
- [x] Add gallery management endpoints (CRUD for photos)
- [x] Add photo upload with S3 integration
- [x] Add category/filtering support

### Frontend
- [x] Create public gallery page with grid layout
- [x] Add lightbox/modal for full-size image viewing
- [x] Add category filtering
- [x] Create admin gallery management interface
- [x] Add photo upload form for admins

## Email Notifications

### Backend
- [x] Research email service integration (SendGrid, AWS SES, or similar)
- [x] Create email notification helper function
- [x] Add email sending to membership application endpoint
- [x] Create email templates (applicant confirmation, admin notification)

### Configuration
- [x] Document email service setup requirements
- [x] Add email configuration to environment variables

**Note:** Email functionality is documented in EMAIL_SETUP.md. User needs to configure email service (Resend, SendGrid, or Nodemailer) and add API keys to enable notifications.

## Events Calendar

### Database & Backend
- [x] Create events table (id, title, description, date, location, type, createdBy, createdAt)
- [x] Add events management endpoints (CRUD for events)
- [x] Add filtering by date/type

### Frontend
- [x] Create public events calendar page
- [x] Add calendar view or list view for events
- [x] Add event detail modal/page
- [x] Create admin events management interface
- [x] Add event creation/editing form for admins
- [x] Add link to events page from homepage


## Content Management System (CMS)

### Database Schema
- [x] Create page_content table (id, page, section, type, content, order, published)
- [x] Create board_members table for styrelse management
- [x] Create site_settings table (id, key, value, type) for global settings like logo
- [x] Run database migrations

### Backend API
- [x] Create API endpoints for fetching page content
- [x] Create API endpoints for updating page content (huvudadmin only)
- [x] Create API endpoints for managing sections (CRUD)
- [x] Create API endpoints for site settings (logo, colors, etc.)
- [x] Add image upload for board members and other images
- [ ] Add versioning/history for content changes

### Admin Interface
- [x] Create CMS dashboard for huvudadmin
- [x] Build page selector (Home, Statutes, Gallery, Events, etc.)
- [x] Create section editor with text fields
- [x] Implement drag-and-drop for section ordering
- [x] Add rich text editor for content sections
- [x] Add image upload interface for each section
- [x] Create site settings editor (logo, contact info, board members)
- [ ] Add live preview of changes
- [x] Add publish/save draft functionality

### Frontend Integration
- [x] Update Home page to use dynamic content from database
- [x] Update Statutes page to use dynamic content
- [x] Update footer contact information to use dynamic data
- [x] Update board members section to use dynamic data
- [x] Add loading states for content fetching
- [x] Implement content caching for performance

**Caching details:**
- CMS page content: 5 min staleTime, 10 min gcTime
- Site settings: 10 min staleTime, 30 min gcTime
- Board members: 10 min staleTime, 30 min gcTime

### Features
- [x] Drag-and-drop section reordering
- [x] Image management (upload, replace, delete)
- [x] Board member management (photo, name, role, phone)
- [x] Logo upload and replacement
- [x] Text editing for all sections
- [x] Section visibility toggle
- [ ] Content versioning/history

### Status
✅ CMS backend and admin interface complete
⏳ Frontend integration pending (pages still use hardcoded content)
💡 Next: Update Home.tsx, Statutes.tsx to fetch content from database


## CMS Frontend Integration

### Dynamic Content Loading
- [x] Update Home.tsx to fetch content from database
- [x] Create helper hook useCMSContent() for fetching page content
- [x] Replace hardcoded hero section with CMS content
- [x] Replace hardcoded about section with CMS content
- [x] Update header logo and site name to use site settings
- [x] Update board members section to use database
- [x] Add loading states for CMS content
- [x] Update Statutes page to fetch content from database
- [x] Replace hardcoded stadgar content with CMS sections

### Version History
- [x] Create content_history table in database
- [x] Add API endpoint to save content versions on update
- [x] Add API endpoint to fetch content history
- [x] Add API endpoint to restore previous version
- [x] Create version history UI in PageEditor with timestamps and usernames
- [x] Add restore button for previous versions
- [x] Show version count and last modified info

### Live Preview
- [x] Create side-by-side layout in PageEditor
- [x] Add live preview panel that updates as user types
- [x] Render HTML content in preview
- [x] Add toggle to show/hide preview panel


## Role Editing Enhancement
- [x] Add click handler to role cards in RoleManagement
- [x] Create role editing dialog with permission checkboxes
- [x] Implement update role permissions functionality
- [x] Show success/error messages after updating


## Hero Section Design Update
- [x] Update hero gradient to use reference colors (dark navy to light blue)
- [x] Increase hero section height for more visual impact
- [x] Enlarge logo size in header
- [x] Test responsive design with new sizes


## Hero Section Animations
- [x] Add fade-in animation to hero title
- [x] Add fade-in animation to hero subtitle with delay
- [x] Add fade-in animation to buttons with staggered delay
- [x] Test animations on different browsers


## Site Settings Save Button
- [x] Add save button to SiteSettingsEditor component
- [x] Implement save functionality for all settings
- [x] Show success message after saving

**Status:** Redan implementerat! Varje inställning har sin egen spara-knapp med omedelbar feedback.


## Image Compression & Optimization
- [x] Install browser-image-compression library
- [x] Create image compression utility function
- [x] Update ImageUpload component to compress before upload
- [x] Set max dimensions (e.g., 1920px width for images)
- [x] Set quality level (e.g., 0.8 for good balance)
- [x] Test with large images


## BankID Integration (via OpenID Connect)

### Backend Setup
- [x] Research and select OIDC provider (Criipto, Signicat, ZignSec, or GrandID)
- [x] Register application with chosen provider (Criipto)
- [x] Add OIDC configuration to environment variables
- [x] Install OIDC client library (openid-client)
- [x] Create BankID OAuth callback route (/auth/bankid/callback)
- [x] Implement OIDC authentication flow
- [x] Extract personnummer from ID token
- [x] Create/update user in database with BankID data
- [x] Set session cookie after successful authentication

### Frontend Integration
- [x] Add "Logga in med BankID" button to login dialog
- [x] Style BankID button with appropriate design
- [x] Handle authentication redirects
- [x] Show loading state during authentication
- [x] Handle authentication errors gracefully
- [x] Add logout button to profile page

### Documentation
- [x] Document OIDC provider setup instructions
- [x] Add environment variables documentation
- [x] Create user guide for BankID login
- [x] Update BANKID_INTEGRATION.md with complete OIDC approach
- [x] Create CRIIPTO_SETUP_GUIDE.md with step-by-step instructions

**Status:** ✅ Implementation klar! BankID-inloggning fungerar via Criipto OIDC.


## Member Registry System

### Database Schema
- [x] Update users table with additional fields (personnummer, street_address, postal_code, city, member_number, join_year, member_type, payment_status)
- [x] Add unique constraint on personnummer
- [x] Auto-generate member numbers (format: SSK-YYYY-XXXX)
- [x] Run database migrations

### Backend API
- [x] Create member list endpoint with filtering (GET /api/members)
- [x] Create member detail endpoint (GET /api/members/:id)
- [x] Create member update endpoint (PUT /api/members/:id) - admin only
- [x] Create member search endpoint (GET /api/members/search)
- [x] Implement role-based field visibility (hide sensitive data from regular members)
- [x] Add pagination for member list

### Admin Interface
- [x] Create member registry page in admin dashboard
- [x] Add member list table with sorting and filtering
- [x] Create member detail/edit modal
- [x] Add search functionality
- [ ] Add bulk actions (export to CSV, bulk status update)
- [ ] Add member statistics dashboard

### Member Directory (Public for logged-in members)
- [x] Create member directory page
- [x] Show limited member info (name, phone, email only)
- [x] Add search and filter functionality
- [x] Implement privacy settings (members can hide their info)
- [x] Add "Contact member" button with email integration

### Features
- [x] Auto-generate member numbers on approval
- [x] Track payment status per year
- [ ] Send payment reminders
- [ ] Export member list to Excel/CSV
- [ ] Member statistics and reports

**Status:** ✅ Medlemsregister implementerat! Admin kan hantera alla medlemsuppgifter, medlemmar kan se varandra i katalogen.


## Unified Login System with Member Verification

### Backend OAuth Integration
- [x] Add Google OAuth provider configuration
- [ ] Add Apple Sign-In provider configuration (TODO: waiting for Apple Developer account)
- [x] Create unified OAuth callback handler for all providers
- [x] Extract user info (email, name, personnummer) from each provider
- [x] Implement member registry verification logic
- [x] Auto-link accounts to member records based on email or personnummer

### Frontend Login Dialog
- [x] Update BankIDLoginDialog to UnifiedLoginDialog
- [x] Add Google Sign-In button with branding
- [ ] Add Apple Sign-In button with branding (TODO: waiting for Apple Developer account)
- [x] Keep existing BankID and Manus login options
- [x] Add visual separation between authentication methods
- [x] Show loading states for each provider

### Member Verification Flow
- [x] Check if logged-in user exists in member registry
- [x] Show verification status after login
- [x] Allow admins to manually link accounts to members
- [x] Display member info on profile page if verified
- [x] Add "Not a member yet?" message with application link

### Security & UX
- [x] Validate email/personnummer format
- [x] Prevent duplicate accounts
- [x] Handle OAuth errors gracefully
- [x] Add privacy policy link in login dialog
- [x] Show clear error messages for non-members

**Status:** ✅ Enhetlig inloggning med Google och BankID klar! Medlemsverifiering fungerar automatiskt.


## Member Registry Import/Export

### Backend Implementation
- [x] Install CSV parsing library (papaparse)
- [x] Install Excel generation library (exceljs)
- [x] Create CSV import endpoint with validation
- [x] Create Excel export endpoint
- [x] Validate imported data (personnummer format, required fields)
- [x] Handle duplicate personnummer on import
- [x] Generate import error report

### Frontend Implementation
- [x] Add "Import CSV" button in admin member registry
- [x] Create file upload dialog with instructions
- [x] Show import progress and results
- [x] Add "Export to Excel" button in admin member registry
- [x] Download generated Excel file automatically

### BankID Personnummer Verification
- [x] Extract personnummer from BankID ID token (YYYYMMDD)
- [x] Check if personnummer exists in member registry
- [x] Block login if personnummer not found
- [x] Show clear error message for non-members
- [x] Log failed login attempts with personnummer
- [x] Create BankIDErrorAlert component for user-friendly error messages

**Status:** ✅ Import/Export och BankID-verifiering klart! Admins kan importera/exportera medlemmar, endast registrerade medlemmar kan logga in med BankID.


## Fix require() Error in Auth Providers
- [x] Replace require() with ES6 import in auth.providers endpoint
- [x] Test that homepage loads without errors
- [x] Verify auth providers query works correctly

**Status:** ✅ Felet fixat! Ersatte require() med async import i auth.providers endpoint.


## Event Management System with Calendar

### Database Schema
- [ ] Create events table (title, description, date, time, location, maxParticipants, registrationDeadline, status)
- [ ] Create event_registrations table (eventId, userId, registeredAt, status, notes)
- [ ] Add indexes for efficient queries
- [ ] Run database migrations

### Backend API
- [ ] Create event CRUD endpoints (admin only)
- [ ] Create event list endpoint (public, filter by upcoming/past)
- [ ] Create event registration endpoint (authenticated users)
- [ ] Create registration cancellation endpoint
- [ ] Implement max participants validation
- [ ] Create participant list endpoint (admin only)
- [ ] Add registration deadline validation

### Admin Interface
- [ ] Create event management page in admin dashboard
- [ ] Add event creation form with date/time picker
- [ ] Add event list table with edit/delete actions
- [ ] Create participant list view for each event
- [ ] Add event statistics (registered/max participants)
- [ ] Implement event status management (draft, published, cancelled, completed)

### Public Event Calendar
- [ ] Create event calendar page with month/list view
- [ ] Display upcoming events on homepage
- [ ] Create event detail page with registration button
- [ ] Implement registration confirmation dialog
- [ ] Show participant count and availability
- [ ] Add "My Events" page for registered events
- [ ] Display registration deadline and event status

### Features
- [ ] Automatic registration deadline enforcement
- [ ] Waitlist functionality when event is full
- [ ] Export participant list to CSV
- [ ] Send confirmation email on registration
- [ ] Send reminder email before event
- [ ] Calendar integration (iCal export)


## Event Management System with Calendar

### Database Schema
- [x] Create events table (id, title, description, event_date, event_time, location, type, max_participants, allow_waitlist, registration_deadline, created_by, created_at, updated_at)
- [x] Create event_registrations table (id, event_id, user_id, status, notes, registered_at)
- [x] Add foreign keys and indexes
- [x] Run database migrations

### Backend API
- [x] Create event CRUD endpoints (list, get, create, update, delete)
- [x] Create registration endpoints (register, cancel, get my registrations)
- [x] Implement automatic waitlist management
- [x] Check max participants before registration
- [ ] Send email notifications on registration (TODO: requires email service setup)
- [x] Admin endpoint to view all registrations for an event

### Admin Interface
- [x] Add event management page in admin dashboard
- [x] Create event form with all fields
- [x] List all events with edit/delete actions
- [x] View participant list for each event (EventParticipants component)
- [ ] Export participant list to CSV (TODO: future enhancement)
- [ ] Manually add/remove participants (TODO: future enhancement)

### Public Event Calendar
- [x] Create event calendar page
- [x] Show upcoming events in card/list view
- [ ] Add calendar month view (TODO: future enhancement)
- [x] Event detail in card with registration button
- [x] Registration form with notes field
- [x] Show registration status (registered, waitlist, full)
- [x] Cancel registration functionality
- [x] Show "My Events" via myEvents query

### Features
- [x] Automatic waitlist promotion when someone cancels
- [x] Registration deadline enforcement
- [ ] Event reminders (1 day before) (TODO: requires scheduled jobs)
- [x] Event capacity tracking
- [x] Event types/categories (Bingo, Vårfest, Match, etc.)

**Status:** ✅ Event-system klart! Medlemmar kan se och anmäla sig till evenemang, admins kan hantera deltagare.


## Document Management System (PDF Upload & Sharing)

### Database Schema
- [x] Create documents table (id, title, description, file_url, file_key, file_size, category, access_level, uploaded_by, created_at, updated_at)
- [x] Add document categories (stadgar, protokoll, informationsblad, arsmoten, ovrigt)
- [x] Add access levels (public, members_only, admin_only)
- [x] Run database migrations

### Backend API
- [x] Create document upload endpoint with S3 integration
- [x] Create document list endpoint with filtering by category
- [x] Create document delete endpoint (admin only)
- [x] Implement access control based on user role
- [x] Add file size validation (max 10MB)
- [x] Add file type validation (PDF only)

### Admin Interface
- [x] Create document management page in admin dashboard (DocumentManagement component)
- [x] Add PDF upload form with title, description, category
- [x] Add access level selector (public/members_only/admin_only)
- [x] List all documents with edit/delete actions
- [x] Show file size and upload date
- [x] Add document preview/download buttons
- [x] Add "Dokument" tab in Admin dashboard

### Public Document Library
- [x] Create document library page (/documents)
- [x] Show documents grouped by category
- [x] Add category tabs for navigation
- [x] Add download and view buttons for each document
- [x] Show document metadata (title, description, size, date)
- [x] Implement access control (hide members-only docs from guests)
- [x] Add access level badges
- [x] Add "Dokument" link in navigation header

### Features
- [x] PDF file upload with validation
- [x] S3 storage integration via storagePut()
- [x] Category-based organization (5 categories)
- [x] Access control (public/members_only/admin_only)
- [ ] Document download tracking (TODO: future enhancement)
- [ ] Document versioning (TODO: future enhancement)

**Status:** ✅ Dokumenthantering klart! Admins kan ladda upp PDF-filer, medlemmar kan se och ladda ner dokument.


## CMS Editor UX Fix - Sticky Save Button

### Issue
- [x] Save button disappears when editing large text blocks in CMS
- [x] User must scroll to find save button after pasting content

### Solution
- [x] Make dialog footer sticky at bottom of viewport
- [x] Ensure save/cancel buttons always visible
- [x] Test with large text content (1000+ words)
- [x] Apply fix to PageEditor component

**Implementation:**
- Added `max-h-[90vh] flex flex-col` to DialogContent
- Made content area scrollable with `overflow-y-auto flex-1`
- Made DialogFooter sticky with `sticky bottom-0 bg-white pt-4 border-t`

**Status:** ✅ Spara-knappen är nu alltid synlig oavsett textmängd!


## CMS Dialog Footer Positioning Fix
- [ ] Move buttons to bottom of dialog frame (not floating)
- [ ] Keep footer as part of dialog structure
- [ ] Ensure buttons remain visible when scrolling content
- [ ] Remove sticky positioning, use flexbox layout instead


## CMS Dialog Footer Positioning Fix
- [x] Move buttons to bottom of dialog frame (not floating)
- [x] Keep footer as part of dialog structure
- [x] Ensure buttons remain visible when scrolling content
- [x] Remove sticky positioning, use flexbox layout instead

**Implementation:**
- Changed DialogContent to use `max-h-[90vh] flex flex-col` layout
- Made content area scrollable with `overflow-y-auto flex-1`
- Removed `sticky` positioning from DialogFooter
- Added `border-t pt-4 mt-4` to DialogFooter for visual separation
- Applied to both create and edit dialogs in PageEditor


## Logo Transparency Fix
- [ ] Investigate why transparent PNG logo shows with white background
- [ ] Check CSS styling on logo image elements
- [ ] Remove any background colors from logo containers
- [ ] Test transparent logo display in header
- [ ] Verify logo works on both light and dark backgrounds


## CMS Image Transparency Indicator
- [x] Add checkerboard pattern background to image previews in CMS
- [x] Apply pattern to logo preview in SiteSettingsEditor
- [x] Apply pattern to board member photo previews
- [x] Apply pattern to any other image uploads in CMS
- [x] Test that transparent PNGs show checkerboard clearly


## Password-Based Login Implementation
- [x] Remove BankID integration code (too expensive)
- [x] Add password field to users table (hashed with bcrypt)
- [x] Implement password hashing and validation
- [x] Create login form with email + password
- [x] Add password reset functionality via email
- [x] Create password reset token system
- [x] Update UnifiedLoginDialog with password login form
- [ ] Test login flow with email + password
- [ ] Add password strength requirements
- [x] Comprehensive code review completed


## Resend Email Integration
- [x] Install Resend npm package
- [x] Request RESEND_API_KEY from user
- [x] Create email service module with Resend client
- [x] Create HTML email template for password reset
- [x] Update password reset procedure to send emails
- [ ] Test email sending functionality
- [x] Add error handling for email failures


## Membership Form Heading Update
- [x] Change heading from "Bli medlem i Gamla SSK-are" to "Ansök om att bli medlem"
- [x] Add membership form section to CMS for easy editing
- [x] Test changes on homepage


## SelectItem Empty Value Error Fix
- [x] Find SelectItem components with empty string values
- [x] Replace empty values with valid non-empty strings or remove items
- [x] Test admin page to verify error is resolved


## Feature 1: Swish Payment Integration
**Beskrivning:** Medlemmar kan betala årsavgift (150 kr) direkt via Swish på webbplatsen

### Backend Implementation
- [ ] Research Swish API options (Swish Commerce API vs payment gateway like Stripe)
- [ ] Add payment table to database schema (payment_id, member_id, amount, status, swish_reference, created_at)
- [ ] Create tRPC procedure for initiating Swish payment
- [ ] Create webhook endpoint for Swish payment confirmation
- [ ] Update member paymentStatus after successful payment
- [ ] Send payment confirmation email to member
- [ ] Add payment history view in admin panel

### Frontend Implementation
- [ ] Create payment page/dialog with Swish QR code
- [ ] Add "Betala med Swish" button on member profile page
- [ ] Show payment status (pending, completed, failed)
- [ ] Display payment history for logged-in members
- [ ] Add payment confirmation page

### Testing & Security
- [ ] Test Swish payment flow in sandbox environment
- [ ] Implement payment verification and fraud prevention
- [ ] Add error handling for failed payments
- [ ] Test webhook security and signature verification

---

## Feature 2: Event Calendar with Google Calendar Sync
**Beskrivning:** Medlemmar kan se föreningsevenemang och prenumerera på dem i sin egen kalender

### Backend Implementation
- [x] Verify events table exists in database (already created)
- [x] Create tRPC procedures for event CRUD operations
- [x] Generate iCal (.ics) feed for all events
- [x] Add Google Calendar integration (Add to Google Calendar button)
- [ ] Create event reminder email system
- [x] Add event registration tracking

### Frontend Implementation
- [x] Create calendar view component (month/week/day views)
- [x] Install and configure calendar library (react-big-calendar)
- [x] Add event detail modal with registration button
- [x] Create "Add to Calendar" button (Google, iCal download)
- [ ] Show upcoming events on homepage
- [x] Add calendar subscription link (iCal feed download)

### Admin Features
- [x] Event creation/editing form in admin panel
- [x] Event registration management
- [ ] Send event notifications to members
- [ ] Export attendee lists

---

## Feature 3: Image Gallery with Automatic Compression
**Beskrivning:** Bildgalleri för föreningsbilder med automatisk optimering för snabbare laddning

### Backend Implementation
- [ ] Add images table to database (id, title, description, url, thumbnail_url, category, uploaded_by, created_at)
- [ ] Install image processing library (sharp)
- [ ] Create image upload endpoint with automatic compression
- [ ] Generate multiple sizes (thumbnail, medium, full)
- [ ] Upload compressed images to S3
- [ ] Create tRPC procedures for gallery CRUD operations
- [ ] Add image categories/tags

### Frontend Implementation
- [ ] Create gallery page with grid layout
- [ ] Add category filter dropdown
- [ ] Implement lazy loading for images
- [ ] Create lightbox/modal for full-size images
- [ ] Add image upload form (admin only)
- [ ] Show image metadata (title, date, photographer)
- [ ] Add pagination or infinite scroll

### Image Optimization
- [ ] Compress images to WebP format
- [ ] Generate thumbnails (300x300px)
- [ ] Generate medium size (800px width)
- [ ] Keep original for download
- [ ] Add EXIF data stripping for privacy
- [ ] Implement progressive loading (blur-up effect)

### Admin Features
- [ ] Bulk image upload
- [ ] Image management (edit, delete)
- [ ] Category management
- [ ] Storage usage statistics

---

## Implementation Priority
1. **Event Calendar** (Most requested by members)
2. **Image Gallery** (Enhances member engagement)
3. **Swish Payment** (Requires external API setup and testing)


## Image Gallery Frontend Completion
- [ ] Create gallery database schema for storing image metadata
- [ ] Add tRPC procedures for image upload with compression
- [ ] Create gallery admin interface for uploading images
- [ ] Build public gallery page with grid layout
- [ ] Implement lightbox component for fullscreen image viewing
- [ ] Add image captions and descriptions
- [ ] Create album/category organization
- [ ] Add lazy loading for gallery images
- [ ] Test image upload and compression

## Swish Payment Integration (Simplified)
- [x] Add payment confirmation table to database
- [x] Add Swish number to site settings (CMS)
- [x] Create payment confirmation upload procedure
- [x] Build payment page showing Swish number and instructions
- [x] Add receipt/confirmation upload functionality
- [x] Create admin interface for verifying payments
- [ ] Send confirmation email when payment is verified
- [ ] Test payment flow with manual confirmation


## Payment Link in Navigation
- [x] Add "Betala medlemsavgift" link to main navigation menu
- [x] Make link visible only for authenticated users
- [x] Style link to stand out (yellow button)
- [x] Test navigation on mobile and desktop

## Upcoming Events on Homepage
- [x] Create upcoming events section on homepage
- [x] Fetch 3 nearest upcoming events from database
- [x] Display event cards with date, title, and registration link
- [x] Add "Se alla evenemang" link to events page
- [x] Test responsive layout

## Automatic Payment Reminders (Cron Job)
- [x] Create cron job script for payment reminders
- [x] Query users with unpaid membership for next year
- [x] Send reminder emails via Resend
- [x] Schedule cron job to run daily at 9 AM
- [x] Add logging for reminder emails sent
- [ ] Test reminder email content and delivery


## Member Import Fix
- [ ] Investigate why import button does nothing
- [ ] Check CSV parsing and validation logic
- [ ] Fix import button click handler
- [ ] Add loading state during import
- [ ] Add success/error feedback after import
- [ ] Test with actual CSV file

## Bug Fixes

- [x] Fix CSV import dialog state persistence - selected file is lost when dialog closes and reopens
- [x] Fix SQL syntax error in generateMemberNumber() function (LIKE query)

## CSV Import Enhancement

- [x] Make CSV import flexible - only name field required, all other fields optional
- [x] Skip empty/missing fields instead of failing validation
- [x] Update UI documentation to reflect new requirements

## CSV Import Fixes for SSK Membership List

- [x] Support semicolon (;) as CSV delimiter (auto-detect)
- [x] Map Swedish memberType values (Aktiv, Hedersmedlem, etc.) to internal format
- [x] Handle missing personnummer column gracefully
- [x] Skip Excel metadata rows (e.g., "Tabell 1")

## Critical Bug Fix

- [x] Fix SQL syntax error in memberImportExport.ts - use centralized generateMemberNumber() function
- [x] Fix LIKE query parameter format - % must be part of value, not SQL syntax

## Member Registry Improvements

- [x] Add sorting functionality for all table columns (including payment status)
- [x] Add manual payment reminder button next to payment status
- [x] Disable automatic email notifications and cron jobs

## Profile Page Improvements

- [x] Add personnummer field to user profile page (Min sida)
- [x] Display payment status and payment year on profile page

## Payment Improvements

- [x] Add Swish QR code to payment warning section on profile page

## Folkspel Integration

- [x] Create Folkspel lottery store landing page with iframe integration
- [x] Add navigation link to Folkspel page

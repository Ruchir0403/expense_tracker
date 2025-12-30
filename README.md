# Personal Expense Tracker

A mobile application developed for the Flutter Developer Technical Assessment. This app allows users to securely track their personal finances, view analytics, and manage expenses with real-time data persistence.

## Project Overview
The **Personal Expense Tracker** is designed to help users manage their daily spending. It follows a strictly typed, modular architecture ensuring scalability and maintainability.

**Key Features:**
* **Secure Authentication:** Email/Password login and signup via Supabase Auth.
* **Expense Management (CRUD):** Users can Create, Read, Update, and Delete expenses.
* **Smart Analytics:** Visual spending insights using interactive charts.
* **Data Security:** Row Level Security (RLS) ensures users can only access their own data.
* **Persistence:** Auto-login functionality using session persistence.

## Tech Stack
* **Frontend:** Flutter (Dart) - Material 3 Design
* **Backend:** Supabase (PostgreSQL, Auth, Realtime)
* **State Management:** Flutter Riverpod (with code generation)
* **Routing:** GoRouter (Declarative routing with Auth Guards)
* **Data Modeling:** json_serializable
* **Charts:** fl_chart

## Setup Instructions

Follow these steps to run the application locally.

### 1. Prerequisites
* Flutter SDK installed (v3.0+)
* Git installed

### 2. Installation
Clone the repository and install dependencies:
```bash
git clone <your-repo-url>
cd expense_tracker
flutter pub get
```

### 3. Environment Setup (Important)
This project uses flutter_dotenv to manage secrets.

* Create a file named .env in the root directory (same level as pubspec.yaml).
* Add your Supabase credentials:
```bash
SUPABASE_URL=[https://your-project-id.supabase.co](https://your-project-id.supabase.co)
SUPABASE_ANON_KEY=your-anon-key-here
```

### 4. Backend Setup (Supabase)
If you are the reviewer, you need to set up the database table. Run the following SQL in your Supabase SQL Editor:
```SQL
-- Create Expenses Table
create table public.expenses (
  id uuid not null default gen_random_uuid(),
  user_id uuid not null references auth.users(id) default auth.uid(),
  title text not null,
  amount numeric not null,
  category text not null,
  expense_date date not null,
  created_at timestamptz not null default now(),
  constraint expenses_pkey primary key (id)
);

-- Enable Security
alter table public.expenses enable row level security;

-- Policies
create policy "Users can view own expenses" on public.expenses for select using (auth.uid() = user_id);
create policy "Users can insert own expenses" on public.expenses for insert with check (auth.uid() = user_id);
create policy "Users can update own expenses" on public.expenses for update using (auth.uid() = user_id);
create policy "Users can delete own expenses" on public.expenses for delete using (auth.uid() = user_id);
```

### 5. Run the App
Generate the data models and run the app:
```bash
# Generate JSON serialization code
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

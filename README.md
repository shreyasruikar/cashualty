# BroCode

# Smart Expense Management System

## Overview

A mobile-first solution to help individuals and groups manage expenses efficiently. Users can track spending, set budgets, split costs within groups, and get alerts when approaching limits.

---

## Problem Statement

Managing day-to-day and shared expenses is often scattered and inefficient. Existing tools either lack collaboration features or real-time alerts. There's a need for a simple, centralized system to track and manage spending, both individually and in groups.

---

## What We Built

- Add, edit, and delete expenses with custom categories
- Create groups for events or shared living to manage collective spending
- Set monthly budgets and receive alerts on thresholds
- View spending trends through graphs and summaries
- Data synced across devices using a cloud backend

---

## Tech Stack

- **Frontend**: Flutter  
- **Backend**: Supabase (Database, Auth, Realtime)  
- **Design**: Figma
- **Database**: PostgreSQL
- **Security**: JWT Verification
- **Notification**: FCM

---

## Figma Design Ideation

[View UI Prototype]([https://www.figma.com/your-figma-link-here](https://www.figma.com/design/5b9MOk67qt9at3WaDiyrUn/Untitled?node-id=0-1&p=f&t=1ZzOoAFxu3IYwteP-0))

---

## Supabase Setup

- Used PostgreSQL to store users, expenses, and groups  
- Enabled real-time updates and notifications via triggers  
- Authentication handled through Supabase Auth  

---

## Run Locally

1. Clone the repo  
2. Install dependencies: `flutter pub get`  
3. Add your Supabase URL and key in config  
4. Run the app: `flutter run`  

---


## Note

This project was developed during a hackathon under time constraints. All code and logic were written by the team.

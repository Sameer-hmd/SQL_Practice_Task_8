# SQL_Practice_Task_8
# ⚙️ Task 8: Stored Procedures and Functions

## 🎯 Objective
Learn how to write reusable SQL logic using stored procedures and functions with parameters, conditional logic, and output handling.

## 🛠 Tool Used
MySQL Workbench

---

## 🧱 Tables Used
- `Book`: Book records with title, genre, and year published
- `Member`: Member information such as name and join date
- `Loan`: Tracks loans with borrow and return details

---

## 🛠️ Key Concepts Practiced

### ✅ Stored Procedures
- Encapsulate frequently-used query logic
- Use `IN`, `OUT`, and `INOUT` parameters
- Perform updates, calculations, and filtered selections
- Support conditional logic using `IF`, `CASE`, and loops

### ✅ Functions
- Return single computed values
- Can be used inside `SELECT` statements
- Accept `IN` parameters only
- Useful for status checks, formatting, and calculations

---

## 🧪 Examples Covered

### 🔹 Procedures with `IN` Parameters
- Get all books of a given genre
- Count loans made by a specific member
- Mark a loan as returned with a given date

### 🔹 Procedures with `OUT` Parameters
- Get total number of books in the library
- Count books in a specific genre
- Return loan summary for a member (total loans and active loans)

### 🔹 Functions
- Combine first and last name into full name
- Check if a book loan is overdue
- Calculate fine amount based on late return (₹10 per day)
- Determine member type: 'New', 'Regular', or 'Frequent' based on loan count

---

## 💡 Learning Outcomes

- Understand how to build reusable and secure SQL blocks
- Use stored procedures for multi-step operations and updates
- Use functions inside queries for calculated or derived columns
- Apply input and output parameters to make procedures dynamic
- Simplify complex business logic in a manageable way

---

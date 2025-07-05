-- Creates a procedure that lists books of a specific genre
DELIMITER //
CREATE PROCEDURE GetBooksByGenre(IN genre_name VARCHAR(50))
BEGIN
    SELECT * FROM Book
    WHERE Genre = genre_name;
END;
//
DELIMITER ;

CALL GetBooksByGenre('Fiction');

-- -------------------------------------------------------------------------------------------------------------

-- Returns the number of loans for a given member ID
DELIMITER //
CREATE PROCEDURE CountLoansByMember(IN member_id INT)
BEGIN
    SELECT COUNT(*) AS TotalLoans
    FROM Loan
    WHERE MemberID = member_id;
END;
//
DELIMITER ;

CALL CountLoansByMember(2);

-- -------------------------------------------------------------------------------------------------------------

-- Updates the return date of a loan by LoanID
DELIMITER //
CREATE PROCEDURE MarkBookAsReturned(IN loan_id INT, IN return_date DATE)
BEGIN
    UPDATE Loan
    SET ReturnDate = return_date
    WHERE LoanID = loan_id;
END;
//
DELIMITER ;

CALL MarkBookAsReturned(3, '2025-07-01');

-- -------------------------------------------------------------------------------------------------------------

-- Returns 1 if overdue, 0 if not
DELIMITER //
CREATE FUNCTION IsOverdue(due_date DATE, return_date DATE)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    IF return_date IS NULL AND due_date < CURDATE() THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
//
DELIMITER ;

SELECT LoanID, IsOverdue(DueDate, ReturnDate) AS OverdueStatus FROM Loan;

-- -------------------------------------------------------------------------------------------------------------

-- Returns fine amount: ₹10 per day if book is overdue
DELIMITER //
CREATE FUNCTION CalculateFine(due DATE, ret DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE fine INT;

    IF ret IS NULL OR ret <= due THEN
        SET fine = 0;
    ELSE
        SET fine = DATEDIFF(ret, due) * 10;
    END IF;

    RETURN fine;
END;
//
DELIMITER ;

SELECT LoanID, DueDate, ReturnDate, CalculateFine(DueDate, ReturnDate) AS Fine
FROM Loan;

-- -------------------------------------------------------------------------------------------------------------

-- Returns 'New', 'Regular', or 'Frequent' based on loan history
DELIMITER //
CREATE FUNCTION GetMemberType(member_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE total_loans INT;
    DECLARE status VARCHAR(20);

    SELECT COUNT(*) INTO total_loans
    FROM Loan
    WHERE MemberID = member_id;

    IF total_loans = 0 THEN
        SET status = 'New';
    ELSEIF total_loans <= 3 THEN
        SET status = 'Regular';
    ELSE
        SET status = 'Frequent';
    END IF;

    RETURN status;
END;
//
DELIMITER ;

SELECT MemberID, Name, GetMemberType(MemberID) AS MemberType
FROM Member;

-- -------------------------------------------------------------------------------------------------------------

-- Accepts genre as input, returns the count of books in that genre
DELIMITER //
CREATE PROCEDURE GetGenreBookCount(IN genre_name VARCHAR(50), OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM Book
    WHERE Genre = genre_name;
END;
//
DELIMITER ;

CALL GetGenreBookCount('Science', @count);
SELECT @count;

-- -------------------------------------------------------------------------------------------------------------

-- Returns total loans and active (not returned) loans for a member
DELIMITER //
CREATE PROCEDURE GetLoanStats(
    IN member_id INT,
    OUT total_loans INT,
    OUT active_loans INT
)
BEGIN
    SELECT COUNT(*) INTO total_loans FROM Loan WHERE MemberID = member_id;
    SELECT COUNT(*) INTO active_loans 
    FROM Loan 
    WHERE MemberID = member_id AND ReturnDate IS NULL;
END;
//
DELIMITER ;

CALL GetLoanStats(1, @total, @active);
SELECT @total AS TotalLoans, @active AS ActiveLoans;





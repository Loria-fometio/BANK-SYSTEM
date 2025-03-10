<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
$host = "localhost"; 
$user = "root"; 
$pass = ""; 
$dbname = "bank_system";

$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Process POST request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $accountNumber = $conn->real_escape_string($_POST['accountNumber']);
    $loanAmount = floatval($_POST['loanAmount']); // Ensure numeric value
    $loanType = $conn->real_escape_string($_POST['loanType']);
    $tenure = intval($_POST['tenure']); // Ensure integer value
    $purpose = $conn->real_escape_string($_POST['purpose']);

    // Get the client ID using the account number
    $clientQuery = $conn->prepare("SELECT id, first_name FROM clients WHERE account_number = ?");
    $clientQuery->bind_param("s", $accountNumber);
    $clientQuery->execute();
    $clientResult = $clientQuery->get_result();

    if ($clientResult->num_rows > 0) {
        $client = $clientResult->fetch_assoc();
        $clientId = $client['id'];
        $clientName = $client['first_name'];

        // Insert loan request into database
        $insertLoan = $conn->prepare("INSERT INTO loan_requests (client_id, loan_amount, loan_type, tenure, purpose, requested_at) VALUES (?, ?, ?, ?, ?, NOW())");
        $insertLoan->bind_param("idiss", $clientId, $loanAmount, $loanType, $tenure, $purpose);

        if ($insertLoan->execute()) {
            // Insert notification for the loan officer
            $notificationMessage = "You received a loan request from $clientName (Account No: $accountNumber).";
            $insertNotification = $conn->prepare("INSERT INTO notifications (client_id, message, sent_at) VALUES (?, ?, NOW())");
            $insertNotification->bind_param("is", $clientId, $notificationMessage);
            $insertNotification->execute();

            echo json_encode(["status" => "success", "message" => "Loan request submitted successfully!"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Error submitting loan request: " . $conn->error]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid account number!"]);
    }

    // Close connections
    $clientQuery->close();
    $insertLoan->close();
    $insertNotification->close();
}

$conn->close();
?>

<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

header('Content-Type: application/json'); // Ensure JSON response

try {
    // Database connection
    $host = "localhost";
    $username = "root";
    $password = "";
    $database = "bank_system";

    $conn = new mysqli($host, $username, $password, $database);
    if ($conn->connect_error) {
        throw new Exception("Database connection failed: " . $conn->connect_error);
    }

    // Get input data
    $rawData = file_get_contents("php://input");
    error_log("Raw input data: " . $rawData); // Debugging: Log the raw input data

    $data = json_decode($rawData, true);
    if (!$data) {
        throw new Exception("Invalid input data.");
    }

    error_log("Decoded input data: " . print_r($data, true)); // Debugging: Log the decoded input data

    $email = $data['email'] ?? '';
    $password = $data['password'] ?? '';

    // Validate input
    if (empty($email) || empty($password)) {
        throw new Exception("Email and password are required.");
    }

    // Check if the client exists in the clients_login table
    $stmt = $conn->prepare("SELECT id, password_hash FROM clients_login WHERE email = ?");
    if ($stmt === false) {
        throw new Exception("Prepare failed: " . $conn->error);
    }

    $stmt->bind_param("s", $email);
    $stmt->execute();
    $stmt->store_result();

    if ($stmt->num_rows > 0) {
        // Client exists, verify password
        $stmt->bind_result($id, $password_hash);
        $stmt->fetch();

        error_log("Password hash from DB: " . $password_hash); // Debugging: Log the password hash from the database

        if (password_verify($password, $password_hash)) {
            // Password is correct, fetch user details from the users table
            $stmt = $conn->prepare("SELECT user_id, full_name FROM users WHERE email = ?");
            if ($stmt === false) {
                throw new Exception("Prepare failed: " . $conn->error);
            }

            $stmt->bind_param("s", $email);
            $stmt->execute();
            $stmt->bind_result($user_id, $full_name);
            $stmt->fetch();
            $stmt->close();

            // Check if the client has a bank account
            $stmt = $conn->prepare("SELECT account_number FROM clients WHERE user_id = ?");
            if ($stmt === false) {
                throw new Exception("Prepare failed: " . $conn->error);
            }

            $stmt->bind_param("i", $user_id);
            $stmt->execute();
            $stmt->store_result();

            if ($stmt->num_rows > 0) {
                // Bank account exists, store user_id in session
                $_SESSION['user_id'] = $user_id;
                echo json_encode(["status" => "success", "message" => "Login successful!"]);
            } else {
                // Bank account not yet created
                echo json_encode(["status" => "success", "message" => "Login successful! Bank account not yet created."]);
            }
        } else {
            // Password is incorrect
            throw new Exception("Invalid email or password.");
        }
    } else {
        // Client does not exist
        throw new Exception("Account not found. Sign up first.");
    }

    $stmt->close();
    $conn->close();
} catch (Exception $e) {
    http_response_code(500); // Internal Server Error
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
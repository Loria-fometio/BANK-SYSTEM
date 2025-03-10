<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

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

    $full_name = $data['full_name'] ?? '';
    $email = $data['email'] ?? '';
    $password = $data['password'] ?? '';
    $user_type = $data['user_type'] ?? 'client';

    // Validate input
    if (empty($full_name) || empty($email) || empty($password)) {
        throw new Exception("All fields are required.");
    }

    // Hash the password
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    // Insert client profile into the users table
    $stmt = $conn->prepare("INSERT INTO users (full_name, email, password, user_type) VALUES (?, ?, ?, ?)");
    if ($stmt === false) {
        throw new Exception("Prepare failed: " . $conn->error);
    }
    $stmt->bind_param("ssss", $full_name, $email, $hashed_password, $user_type);
    $stmt->execute();
    $user_id = $stmt->insert_id; // Get the auto-generated user ID
    $stmt->close();

    // Insert login credentials into the clients_login table
    $stmt = $conn->prepare("INSERT INTO clients_login (email, password_hash) VALUES (?, ?)");
    if ($stmt === false) {
        throw new Exception("Prepare failed: " . $conn->error);
    }
    $stmt->bind_param("ss", $email, $hashed_password);
    $stmt->execute();
    $stmt->close();

    echo json_encode(["status" => "success", "message" => "Sign up successful!"]);
} catch (Exception $e) {
    http_response_code(500); // Internal Server Error
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
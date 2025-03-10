<?php
// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Database connection
$host = "localhost";
$user = "root";
$pass = "";
$dbname = "Bank_system";

$conn = new mysqli($host, $user, $pass, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Initialize variables
$search = isset($_GET['search']) ? htmlspecialchars($_GET['search']) : '';
$accountType = isset($_GET['account_type']) ? htmlspecialchars($_GET['account_type']) : '';
$pincode = isset($_GET['pincode']) ? htmlspecialchars($_GET['pincode']) : '';
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$limit = 10; // Number of records per page
$offset = ($page - 1) * $limit;
$result = null;
$totalRows = 0;
$totalPages = 1;

// Search and Filter functionality
$searchCondition = '';
$searchParams = [];
if ($search || $accountType || $pincode) {
    $searchCondition = "WHERE ";
    $conditions = [];
    if ($search) {
        $conditions[] = "(first_name LIKE ? OR email LIKE ? OR phone LIKE ?)";
        $searchParams[] = "%$search%";
        $searchParams[] = "%$search%";
        $searchParams[] = "%$search%";
    }
    if ($accountType) {
        $conditions[] = "account_type = ?";
        $searchParams[] = $accountType;
    }
    if ($pincode) {
        $conditions[] = "pincode = ?";
        $searchParams[] = $pincode;
    }
    $searchCondition .= implode(" AND ", $conditions);
}

// Fetch total number of records for pagination
$totalQuery = "SELECT COUNT(*) AS total FROM clients $searchCondition";
$stmt = $conn->prepare($totalQuery);
if ($searchCondition) {
    $stmt->bind_param(str_repeat('s', count($searchParams)), ...$searchParams);
}
$stmt->execute();
$totalResult = $stmt->get_result();
if ($totalResult) {
    $totalRows = $totalResult->fetch_assoc()['total'];
    $totalPages = max(1, ceil($totalRows / $limit));
}

// Fetch client data with pagination and search
$sql = "SELECT id, first_name, email, phone, account_number, pincode, account_type, user_id FROM clients $searchCondition LIMIT ? OFFSET ?";
$stmt = $conn->prepare($sql);

if ($searchCondition) {
    // Combine search parameters with limit and offset
    $params = array_merge($searchParams, [$limit, $offset]);
    $stmt->bind_param(str_repeat('s', count($searchParams)) . 'ii', ...$params);
} else {
    $stmt->bind_param("ii", $limit, $offset);
}

$stmt->execute();
$result = $stmt->get_result();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client List</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .container {
            margin-top: 50px;
        }
        h2 {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
        }
        .table {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
            border: 1px solid #dee2e6;
            padding: 12px;
        }
        .table thead {
            background-color: #007bff;
            color: #fff;
        }
        .table tbody tr:hover {
            background-color: #f1f1f1;
            transition: background-color 0.3s ease;
        }
        .no-clients {
            font-size: 18px;
            color: #6c757d;
        }
        .search-box {
            max-width: 400px;
            margin: 0 auto 20px auto;
        }
        .export-buttons {
            margin-bottom: 20px;
            text-align: center;
        }
        .export-buttons .btn {
            margin: 5px;
        }
        .pagination {
            margin-top: 20px;
        }
        .bi {
            margin-right: 5px;
        }
        /* Modal Styling */
        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
        .modal-header {
            border-bottom: none;
            padding: 20px;
        }
        .modal-title {
            font-size: 1.5rem;
            font-weight: 600;
        }
        .modal-body {
            padding: 20px;
        }
        .modal-footer {
            border-top: none;
            padding: 20px;
        }
        .form-label {
            font-weight: 500;
            margin-bottom: 5px;
        }
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px;
            border: 1px solid #ddd;
            transition: border-color 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: none;
        }
        .invalid-feedback {
            font-size: 0.875rem;
            color: #dc3545;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<div class="container">
    <h2><i class="bi bi-people-fill"></i> Client List</h2>

    <!-- Add Client Button -->
    <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addClientModal">
        <i class="bi bi-plus"></i> Add Client
    </button>

    <!-- Search Box -->
    <form method="GET" action="" class="search-box">
        <div class="input-group">
            <input type="text" name="search" class="form-control" placeholder="Search by name, email, or phone" value="<?= $search ?>">
            <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> Search</button>
        </div>
    </form>

    <!-- Client Table -->
    <table class="table table-hover table-striped table-primary">
        <thead class="table-primary">
            <tr>
                <th><i class="bi bi-hash"></i> ID</th>
                <th><i class="bi bi-person"></i> First Name</th>
                <th><i class="bi bi-envelope"></i> Email</th>
                <th><i class="bi bi-telephone"></i> Phone</th>
                <th><i class="bi bi-wallet"></i> Account Number</th>
                <th><i class="bi bi-pin-map"></i> Pincode</th>
                <th><i class="bi bi-wallet2"></i> Account Type</th>
                <th><i class="bi bi-wallet2"></i>user id</th>

            </tr>
        </thead>
        <tbody>
            <?php
            if ($result && $result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    echo "<tr>
                        <td>{$row['id']}</td>
                        <td>{$row['first_name']}</td>
                        <td>{$row['email']}</td>
                        <td>{$row['phone']}</td>
                        <td>{$row['account_number']}</td>
                        <td>{$row['pincode']}</td>
                        <td>{$row['account_type']}</td>
                        <td>{$row['user_id']}</td>

                    </tr>";
                }
            } else {
                echo "<tr>
                    <td colspan='7' class='text-center no-clients'><i class='bi bi-exclamation-circle'></i> No clients found</td>
                </tr>";
            }
            ?>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
            <?php if ($page > 1): ?>
                <li class="page-item">
                    <a class="page-link" href="?page=<?= $page - 1 ?>&search=<?= urlencode($search) ?>&account_type=<?= urlencode($accountType) ?>&pincode=<?= urlencode($pincode) ?>" aria-label="Previous">
                        <span aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
                    </a>
                </li>
            <?php endif; ?>

            <?php for ($i = 1; $i <= $totalPages; $i++): ?>
                <li class="page-item <?= $i === $page ? 'active' : '' ?>">
                    <a class="page-link" href="?page=<?= $i ?>&search=<?= urlencode($search) ?>&account_type=<?= urlencode($accountType) ?>&pincode=<?= urlencode($pincode) ?>"><?= $i ?></a>
                </li>
            <?php endfor; ?>

            <?php if ($page < $totalPages): ?>
                <li class="page-item">
                    <a class="page-link" href="?page=<?= $page + 1 ?>&search=<?= urlencode($search) ?>&account_type=<?= urlencode($accountType) ?>&pincode=<?= urlencode($pincode) ?>" aria-label="Next">
                        <span aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                    </a>
                </li>
            <?php endif; ?>
        </ul>
    </nav>
</div>

<!-- Add Client Modal -->
<div class="modal fade" id="addClientModal" tabindex="-1" aria-labelledby="addClientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addClientModalLabel">
                    <i class="bi bi-person-plus"></i> Add New Client
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form id="addClientForm" class="needs-validation" novalidate>
                    <!-- First Name -->
                    <div class="mb-3">
                        <label for="first_name" class="form-label">
                            <i class="bi bi-person"></i> First Name
                        </label>
                        <input type="text" class="form-control" id="first_name" name="first_name" placeholder="Enter first name" required>
                        <div class="invalid-feedback">Please enter a valid first name.</div>
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label">
                            <i class="bi bi-envelope"></i> Email
                        </label>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
                        <div class="invalid-feedback">Please enter a valid email address.</div>
                    </div>

                    <!-- Phone -->
                    <div class="mb-3">
                        <label for="phone" class="form-label">
                            <i class="bi bi-telephone"></i> Phone
                        </label>
                        <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number" required>
                        <div class="invalid-feedback">Please enter a valid phone number.</div>
                    </div>

                    <!-- Account Number -->
                    <div class="mb-3">
                        <label for="account_number" class="form-label">
                            <i class="bi bi-wallet"></i> Account Number
                        </label>
                        <input type="text" class="form-control" id="account_number" name="account_number" placeholder="Enter account number" required>
                        <div class="invalid-feedback">Please enter a valid account number.</div>
                    </div>

                    <!-- Pincode -->
                    <div class="mb-3">
                        <label for="pincode" class="form-label">
                            <i class="bi bi-pin-map"></i> Pincode
                        </label>
                        <input type="text" class="form-control" id="pincode" name="pincode" placeholder="Enter pincode" required>
                        <div class="invalid-feedback">Please enter a valid pincode.</div>
                    </div>

                    <!-- Account Type -->
                    <div class="mb-3">
                        <label for="account_type" class="form-label">
                            <i class="bi bi-wallet2"></i> Account Type
                        </label>
                        <select class="form-select" id="account_type" name="account_type" required>
                            <option value="" disabled selected>Select account type</option>
                            <option value="Savings">Savings</option>
                            <option value="Checking">Checking</option>
                        </select>
                        <div class="invalid-feedback">Please select an account type.</div>
                    </div>
                </form>
            </div>

            <!-- Modal Footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <i class="bi bi-x"></i> Close
                </button>
                <button type="button" class="btn btn-primary" id="saveClient">
                    <i class="bi bi-save"></i> Save Client
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Real-time Validation
    document.getElementById('addClientForm').addEventListener('submit', function (e) {
        if (!this.checkValidity()) {
            e.preventDefault();
            e.stopPropagation();
        }
        this.classList.add('was-validated');
    });

    // AJAX for Adding Clients
    document.getElementById('saveClient').addEventListener('click', function () {
        const form = document.getElementById('addClientForm');
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return;
        }

        const formData = new FormData(form);
        const saveButton = this;
        saveButton.innerHTML = '<i class="bi bi-arrow-repeat"></i> Saving...';
        saveButton.disabled = true;

        fetch('clients.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                alert(data.message);
                location.reload(); // Reload the page to show the new client
            } else {
                alert(data.message);
            }
        })
        .catch(error => {
            alert('An error occurred. Please try again.');
        })
        .finally(() => {
            saveButton.innerHTML = '<i class="bi bi-save"></i> Save Client';
            saveButton.disabled = false;
        });
    });
</script>
</body>
</html>
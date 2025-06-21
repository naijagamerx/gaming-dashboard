<?php
// tests/bootstrap.php

// Set error reporting for tests
error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

// Set a default timezone if not set
if (!ini_get('date.timezone')) {
    date_default_timezone_set('UTC');
}

// Define a base path for easier requiring of files
if (!defined('BASE_PATH')) {
    define('BASE_PATH', dirname(__DIR__));
}

// Autoloader:
// If you were using Composer, you would include its autoloader:
// require_once BASE_PATH . '/vendor/autoload.php';

// For now, since we don't have a Composer autoloader set up for the 'app' directory
// specifically (only for dependencies if we had them), we might need to manually
// require files or set up a simple autoloader here for the 'app' namespace if we
// start using namespaces.
// Given the current project structure (manual requires in index.php),
// test files will also use manual `require_once` statements relative to BASE_PATH.
// This bootstrap file can be used for global test setup, constants, or helper functions.


// Example: You might want to start sessions for tests that need it,
// but be careful as this can affect test isolation if not handled properly.
// if (session_status() == PHP_SESSION_NONE) {
//     // For testing, it's often better to mock session interactions or use a test-specific session handler.
//     // Starting a real session here might lead to "headers already sent" issues if tests output anything before session_start().
//     // Or, if your classes always start sessions (like AuthService), this might be okay or might conflict.
//     // For unit tests, direct session manipulation should ideally be mocked.
// }

// You could define global helper functions for your tests here, if any.

// echo "Test bootstrap loaded.\n"; // Optional: for debugging bootstrap execution
?>

<?php

// app/Config/database.php

class Database {
    private static $instance = null;
    private $connection;

    private $host = 'localhost';
    private $dbname = 'gaming-dashboard';
    private $username = 'root';
    private $password = 'root';

    private function __construct() {
        try {
            $this->connection = new PDO(
                "mysql:host={$this->host};dbname={$this->dbname};charset=utf8mb4",
                $this->username,
                $this->password,
                [
                    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                    PDO::ATTR_EMULATE_PREPARES => false,
                    // PDO::ATTR_PERSISTENT => true // Persistent connections can sometimes cause issues with MAMP. Disable if necessary.
                ]
            );
        } catch(PDOException $e) {
            error_log("Database connection failed: " . $e->getMessage());
            // In a real application, you might want to handle this more gracefully
            // For now, we'll just die with an error message.
            die("Database connection failed. Check error logs. Error: " . $e->getMessage());
        }
    }

    public static function getInstance() {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function getConnection() {
        return $this->connection;
    }

    // Optional: A method to test the connection
    public static function testConnection() {
        try {
            $db = self::getInstance();
            $stmt = $db->getConnection()->query("SELECT 1");
            return $stmt->fetchColumn() === '1';
        } catch (PDOException $e) {
            error_log("Database test connection failed: " . $e->getMessage());
            return false;
        }
    }
}

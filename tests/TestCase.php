<?php
// tests/TestCase.php

// If using Composer's autoloader and PSR-4 for tests namespace:
// namespace Tests;

use PHPUnit\Framework\TestCase as PHPUnitTestCase;

// Define BASE_PATH if not already defined (e.g., if bootstrap.php wasn't included by PHPUnit for some reason)
if (!defined('BASE_PATH')) {
    define('BASE_PATH', dirname(__DIR__));
}

/**
 * Base TestCase class for the project.
 *
 * All test classes should extend this class.
 * It can be used for common setup, teardown, helper methods, or custom assertions.
 */
abstract class TestCase extends PHPUnitTestCase
{
    /**
     * Runs before each test method.
     */
    protected function setUp(): void
    {
        parent::setUp();
        // Example: Reset $_SESSION or other global states if necessary for test isolation.
        // Be cautious with global state manipulation; mocking is often preferred.
        // $_SESSION = []; // Uncomment if you need to clear session before each test
    }

    /**
     * Runs after each test method.
     */
    protected function tearDown(): void
    {
        // Example: Clean up resources created during a test.
        parent::tearDown();
    }

    /**
     * Helper method to mock a class.
     *
     * @param string $className The class name to mock.
     * @return \PHPUnit\Framework\MockObject\MockObject
     */
    protected function mock(string $className)
    {
        return $this->getMockBuilder($className)
                    ->disableOriginalConstructor() // Usually disable constructor for unit tests
                    ->disableOriginalClone()
                    ->disableArgumentCloning()
                    ->disallowMockingUnknownTypes()
                    ->getMock();
    }

    /**
     * Helper method to access private or protected properties of an object for testing.
     * Use with caution, as it breaks encapsulation. Prefer testing public API.
     *
     * @param object $object The object to inspect.
     * @param string $propertyName The name of the property.
     * @return mixed The value of the property.
     * @throws \ReflectionException If the property does not exist.
     */
    protected function getPrivateProperty(object $object, string $propertyName)
    {
        $reflection = new \ReflectionClass($object);
        $property = $reflection->getProperty($propertyName);
        // Before PHP 8.1: $property->setAccessible(true);
        return $property->getValue($object);
    }

    /**
     * Helper method to call private or protected methods of an object for testing.
     * Use with caution, as it breaks encapsulation. Prefer testing public API.
     *
     * @param object $object The object on which to call the method.
     * @param string $methodName The name of the method.
     * @param array $arguments Arguments to pass to the method.
     * @return mixed The result of the method call.
     * @throws \ReflectionException If the method does not exist.
     */
    protected function callPrivateMethod(object $object, string $methodName, array $arguments = [])
    {
        $reflection = new \ReflectionClass($object);
        $method = $reflection->getMethod($methodName);
        // Before PHP 8.1: $method->setAccessible(true);
        return $method->invokeArgs($object, $arguments);
    }
}
?>

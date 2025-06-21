<?php
// tests/Unit/Models/UserModelTest.php

require_once BASE_PATH . '/tests/TestCase.php';
require_once BASE_PATH . '/app/Models/User.php';
// Database and AuthService might be needed if UserModel uses them statically, but ideally, it only uses its $db property.
require_once BASE_PATH . '/app/Services/AuthService.php'; // For AuthService::hashPassword

class UserModelTest extends TestCase
{
    private $dbMock;
    private $pdoStatementMock;
    private User $userModel;

    protected function setUp(): void
    {
        parent::setUp();

        $this->pdoStatementMock = $this->mock(PDOStatement::class);
        $this->dbMock = $this->mock(PDO::class);

        // To properly test UserModel, we need to inject the mocked DB connection.
        // This requires UserModel's constructor or a setter to accept the PDO instance.
        // Current UserModel constructor: public function __construct() { $this->db = Database::getInstance()->getConnection(); }
        // This makes it hard to unit test in isolation.
        //
        // OPTION 1: REFLECTOR TO SET PROTECTED $db PROPERTY (less clean, but works for existing code)
        $this->userModel = new User(); // Instantiate real User model
        $reflection = new ReflectionClass($this->userModel);
        $dbProperty = $reflection->getProperty('db');
        // $dbProperty->setAccessible(true); // For PHP < 8.1
        $dbProperty->setValue($this->userModel, $this->dbMock);

        // OPTION 2: MODIFY USERMODEL FOR DI (preferred for new code / refactoring)
        // class User extends BaseModel { public function __construct(PDO $db) { $this->db = $db; } ... }
        // Then in test: $this->userModel = new User($this->dbMock);
        // For these stubs, we'll use Option 1 to work with the current UserModel structure.
    }

    public function testFindByIdentifierUserExists()
    {
        $expectedUser = ['identifier' => 'testuser', 'group' => 'user', 'password_hash' => 'somehash'];
        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->with($this->stringContains("SELECT * FROM users WHERE identifier = :id"))
            ->willReturn($this->pdoStatementMock);
        $this->pdoStatementMock->expects($this->once())->method('bindParam')->with(':id', 'testuser');
        $this->pdoStatementMock->expects($this->once())->method('execute');
        $this->pdoStatementMock->expects($this->once())
            ->method('fetch')
            ->with(PDO::FETCH_ASSOC)
            ->willReturn($expectedUser);

        $user = $this->userModel->findByIdentifier('testuser');
        $this->assertEquals($expectedUser, $user);
    }

    public function testFindByIdentifierUserNotFound()
    {
        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->willReturn($this->pdoStatementMock);
        $this->pdoStatementMock->expects($this->once())->method('execute');
        $this->pdoStatementMock->expects($this->once())
            ->method('fetch')
            ->with(PDO::FETCH_ASSOC)
            ->willReturn(false);

        $user = $this->userModel->findByIdentifier('unknownuser');
        $this->assertFalse($user);
    }

    public function testGetAllUsers()
    {
        $expectedUsers = [
            ['identifier' => 'user1', 'group' => 'admin'],
            ['identifier' => 'user2', 'group' => 'user']
        ];
        $this->dbMock->expects($this->once())
            ->method('prepare')
            // Basic query without search term for this test
            ->with($this->stringContains("SELECT * FROM users ORDER BY identifier ASC LIMIT :limit OFFSET :offset"))
            ->willReturn($this->pdoStatementMock);

        // Expect bindParam for limit and offset
        $this->pdoStatementMock->expects($this->exactly(2))->method('bindParam'); // Simplified, check specific params if needed
        $this->pdoStatementMock->expects($this->once())->method('execute');
        $this->pdoStatementMock->expects($this->once())
            ->method('fetchAll')
            ->with(PDO::FETCH_ASSOC)
            ->willReturn($expectedUsers);

        $users = $this->userModel->getAllUsers(10, 0);
        $this->assertEquals($expectedUsers, $users);
    }

    public function testGetAllUsersWithSearch()
    {
        $expectedUsers = [['identifier' => 'searchuser', 'group' => 'user']];
        $searchTerm = 'searchuser';
        // Query will contain WHERE clause with LIKE for identifier or group
        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->with($this->stringContains("WHERE identifier LIKE :searchTerm OR `group` LIKE :searchTerm"))
            ->willReturn($this->pdoStatementMock);

        $this->pdoStatementMock->expects($this->exactly(3))->method('bindParam'); // searchTerm, limit, offset
        $this->pdoStatementMock->expects($this->once())->method('execute');
        $this->pdoStatementMock->expects($this->once())
            ->method('fetchAll')
            ->with(PDO::FETCH_ASSOC)
            ->willReturn($expectedUsers);

        $users = $this->userModel->getAllUsers(10,0, $searchTerm);
        $this->assertEquals($expectedUsers, $users);
    }


    public function testGetTotalUserCount()
    {
        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->with($this->stringContains("SELECT COUNT(*) FROM users"))
            ->willReturn($this->pdoStatementMock);
        $this->pdoStatementMock->expects($this->once())->method('execute');
        $this->pdoStatementMock->expects($this->once())
            ->method('fetchColumn')
            ->willReturn(5);

        $count = $this->userModel->getTotalUserCount();
        $this->assertEquals(5, $count);
    }

    public function testCreateUserSuccess()
    {
        $userData = [
            'identifier' => 'newuser',
            'password' => 'password123',
            'group' => 'user'
            // Other fields will use defaults from model's createUser method
        ];

        // Expect prepare for INSERT
        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->with($this->stringContains("INSERT INTO users"))
            ->willReturn($this->pdoStatementMock);

        // Expect execute to be called
        $this->pdoStatementMock->expects($this->once())
            ->method('execute')
            // ->with( $this->callback(function($params) use ($userData) {
            //     $this->assertEquals($userData['identifier'], $params[':identifier']);
            //     $this->assertTrue(password_verify($userData['password'], $params[':password_hash'] ?? ''));
            //     return true;
            // }))
            ->willReturn(true);

        // Expect lastInsertId or similar depending on PK handling in BaseModel
        // UserModel's PK is 'identifier', which is not auto-increment.
        // BaseModel's create returns $data[$this->primaryKey] if set.

        $result = $this->userModel->createUser($userData);
        $this->assertEquals($userData['identifier'], $result); // Expecting the identifier back
    }

    public function testCreateUserMissingRequiredFields()
    {
        $userData = ['identifier' => 'newuser']; // Missing password and group
        // No DB interaction expected, should fail validation in model
        $result = $this->userModel->createUser($userData);
        $this->assertFalse($result);
    }


    public function testUpdateUserSuccess()
    {
        $identifier = 'existinguser';
        $updateData = ['group' => 'admin', 'warnings' => 1];

        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->with($this->stringContains("UPDATE users SET"))
            ->willReturn($this->pdoStatementMock);
        $this->pdoStatementMock->expects($this->once())
            ->method('execute')
            // ->with( $this->callback(function($params) use ($identifier, $updateData) {
            //     $this->assertEquals($updateData['group'], $params[':group']);
            //     $this->assertEquals($updateData['warnings'], $params[':warnings']);
            //     $this->assertEquals($identifier, $params[':primary_key_id']);
            //     return true;
            // }))
            ->willReturn(true);

        $result = $this->userModel->updateUser($identifier, $updateData);
        $this->assertTrue($result);
    }

    public function testUpdateUserWithPasswordChange()
    {
        $identifier = 'existinguser';
        $updateData = ['password' => 'newPassword123'];

        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->willReturn($this->pdoStatementMock);
        $this->pdoStatementMock->expects($this->once())
            ->method('execute')
            // ->with($this->callback(function($params){
            //     $this->assertTrue(isset($params[':password_hash']));
            //     return true;
            // }))
            ->willReturn(true);

        $result = $this->userModel->updateUser($identifier, $updateData);
        $this->assertTrue($result);
    }


    public function testDeleteUserSuccess()
    {
        $identifier = 'usertodelete';
        $this->dbMock->expects($this->once())
            ->method('prepare')
            ->with($this->stringContains("DELETE FROM users WHERE identifier = :id"))
            ->willReturn($this->pdoStatementMock);
        $this->pdoStatementMock->expects($this->once())->method('bindParam')->with(':id', $identifier);
        $this->pdoStatementMock->expects($this->once())
            ->method('execute')
            ->willReturn(true);

        $result = $this->userModel->deleteUser($identifier);
        $this->assertTrue($result);
    }
}
?>

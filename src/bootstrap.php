<?php

namespace App;

use Doctrine\DBAL\DriverManager;
use Monolog\Handler\StreamHandler;
use Monolog\Logger;

require __DIR__ . '/../vendor/autoload.php';

$logger = new Logger('app');
$logger->pushHandler(new StreamHandler('php://stdout', Logger::DEBUG));

$database = DriverManager::getConnection(['url' => 'mysql://pingpong:YQvaW9R3t6ztuLJJ@mysql/pingpong?serverVersion=mariadb-10.4.15']);

// Make sure the command can be stopped
pcntl_signal(SIGINT, function () use ($logger) {
    $logger->info('Manually terminated');
    die;
});

$container = [
    'logger'   => $logger,
    'database' => $database,
];

return $container;

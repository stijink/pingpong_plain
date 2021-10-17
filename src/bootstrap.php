<?php

namespace App;

use Monolog\Handler\StreamHandler;
use Monolog\Logger;

const PINGPONG_PORT     = 3000;
const PINGPONG_SERVER   = 'localhost';

require __DIR__ . '/../vendor/autoload.php';

$logger = new Logger('app');
$logger->pushHandler(new StreamHandler('php://stdout', Logger::DEBUG));

// Make sure the command can be stopped
pcntl_signal(SIGINT, function () use ($logger) {
    $logger->info('Manually terminated');
    die;
});

$container['logger'] = $logger;

return $container;

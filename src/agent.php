<?php

namespace App;

use function Ratchet\Client\connect;

$container = require __DIR__ . '/bootstrap.php';
$logger    = $container['logger'];

$logger->info('PingPong agent started');

connect('ws://' . $_SERVER['HOSTNAME'] . ':' . $_ENV['PINGPONG_PORT'] . '/')->then(function($conn) use ($logger) {

    $logger->info('Connected to PingPong Server at ' . $_ENV['PINGPONG_SERVER'] . ':' . $_ENV['PINGPONG_PORT']);

    $payload = [
        'hostname'  => 'cloud-pi',
        'ipaddress' => '192.168.178.10',
        'load'      => sprintf('%01.2f', sys_getloadavg()[0]),
    ];

    $conn->send(json_encode($payload));

}, function ($e) use ($logger) {
    $logger->error('Could not connect to PingPong Server at ' . $_ENV['PINGPONG_SERVER'] . ':' . $_ENV['PINGPONG_PORT']);
    $logger->error($e->getMessage());
});

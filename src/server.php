<?php

namespace App;

use App\Component\WebsocketHandler;
use Ratchet\App;

$container = require __DIR__ . '/bootstrap.php';

$container['logger']->info('PingPong Server started on ' . $_ENV['PINGPONG_SERVER'] . ':' . $_ENV['PINGPONG_PORT']);

// Run the server application through the WebSocket protocol on port 3000
$app = new App($_ENV['PINGPONG_SERVER'], $_ENV['PINGPONG_PORT'], '0.0.0.0');
$app->route('/', new WebsocketHandler($container['logger']), array('*'));
$app->run();

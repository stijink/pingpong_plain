<?php

namespace App;

use Exception;
use Psr\Log\LoggerInterface;
use Ratchet\App;
use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

use SplObjectStorage;

$container = require __DIR__ . '/bootstrap.php';
$logger    = $container['logger'];

/**
 * chat.php
 * Send any incoming messages to all connected clients (except sender)
 */
class MyChat implements MessageComponentInterface {

    private $clients;

    public function __construct(private LoggerInterface $logger) {
        $this->clients = new SplObjectStorage;
    }

    public function onOpen(ConnectionInterface $conn) {
        $this->logger->debug("connection #{$conn->resourceId} opened");
        $this->clients->attach($conn);
    }

    public function onMessage(ConnectionInterface $from, $payload) {

        $this->logger->debug("New Message on connection #{$from->resourceId}", [
            'payload' => $payload,
        ]);

        dump(json_decode($payload, true));

//        foreach ($this->clients as $client) {
//            if ($from != $client) {
//                $client->send($msg);
//            }
//        }
    }

    public function onClose(ConnectionInterface $conn) {
        $this->logger->debug("connection #{$conn->resourceId} closed");
        $this->clients->detach($conn);
    }

    public function onError(ConnectionInterface $conn, Exception $e) {
        $this->logger->error($e->getMessage());
        $conn->close();
    }
}

$logger->info('PingPong Server started on ' . PINGPONG_SERVER . ':' . PINGPONG_PORT);

// Run the server application through the WebSocket protocol on port 3000
$app = new App(PINGPONG_SERVER, PINGPONG_PORT);
$app->route('/', new MyChat($logger), array('*'));
$app->run();

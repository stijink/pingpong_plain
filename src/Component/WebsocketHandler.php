<?php

namespace App\Component;

use Psr\Log\LoggerInterface;
use Ratchet\ConnectionInterface;
use Ratchet\MessageComponentInterface;

class WebsocketHandler implements MessageComponentInterface {

    private $clients;

    public function __construct(private LoggerInterface $logger) {
        $this->clients = new \SplObjectStorage;
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

    public function onError(ConnectionInterface $conn, \Exception $e) {
        $this->logger->error($e->getMessage());
        $conn->close();
    }
}

<?php

namespace App;

class Payload
{
    public string $hostname;

    public string $ipaddress;

    public string $load;

    public function __construct(?array $payload = null)
    {
        if (is_array($payload)) {
            foreach ($payload as $key => $value) {
                $this->$key = $value;
            }
        }
    }
}

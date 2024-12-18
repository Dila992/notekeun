<?php

namespace Config;

use CodeIgniter\Config\BaseConfig;

class Cors extends BaseConfig
{
    public array $default = [
        'allowedOrigins' => ['*'], // Mengizinkan semua origin selama pengembangan
        'allowedOriginsPatterns' => [],

        'supportsCredentials' => true, // True jika menggunakan cookie atau token

        'allowedHeaders' => ['*'], // Mengizinkan semua header
        'exposedHeaders' => [],

        'allowedMethods' => ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'], // Semua method umum

        'maxAge' => 7200, // Cache preflight request selama 2 jam
    ];
}

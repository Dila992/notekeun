<?php

namespace App\Filters;

use CodeIgniter\HTTP\RequestInterface;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\Filters\FilterInterface;
use Config\Services; 

class CorsFilter implements FilterInterface
{
    public function before(RequestInterface $request, $arguments = null)
    {
        // Menambahkan header CORS
        header('Access-Control-Allow-Origin: *'); // Biarkan semua origin bisa mengakses
        header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE'); // Tentukan metode yang diizinkan
        header('Access-Control-Allow-Headers: Content-Type, Authorization'); // Tentukan headers yang diizinkan

        // Jika permintaan adalah preflight request (OPTIONS), langsung beri respon 200 OK
        if ($request->getMethod() === 'options') {
            return Services::response()->setStatusCode(200);
        }
    }

    public function after(RequestInterface $request, ResponseInterface $response, $arguments = null)
    {
        // Tidak ada tambahan header setelah request, jadi biarkan kosong
    }
}

<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->group('api', ['namespace' => 'App\Controllers'], function ($routes) {
    $routes->get('notes', 'NoteController::index');
    $routes->get('notes/(:num)', 'NoteController::show/$1');
    $routes->post('notes', 'NoteController::create');
    $routes->put('notes/(:num)', 'NoteController::update/$1');
    $routes->delete('notes/(:num)', 'NoteController::delete/$1');
});



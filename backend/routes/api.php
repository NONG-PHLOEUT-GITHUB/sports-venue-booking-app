<?php

use App\Http\Controllers\Api\VenueController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');


// 🌐 Public APIs
// Route::get('/sports', [SportController::class, 'index']);
Route::get('/venues', [VenueController::class, 'index']);
// Route::get('/fields', [FieldController::class, 'index']);
// Route::get('/bookings', [BookingController::class, 'index']);

// // 📌 Optional: show single record
// Route::get('/sports/{id}', [SportController::class, 'show']);
// Route::get('/venues/{id}', [VenueController::class, 'show']);
// Route::get('/fields/{id}', [FieldController::class, 'show']);
// Route::get('/bookings/{id}', [BookingController::class, 'show']);

// // ✏️ Protected CRUD routes (use Sanctum or middleware if needed)
// Route::post('/bookings', [BookingController::class, 'store']);
// Route::put('/bookings/{id}', [BookingController::class, 'update']);
// Route::delete('/bookings/{id}', [BookingController::class, 'destroy']);

<?php

namespace Database\Seeders;

use App\Models\Booking;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class BookingSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Booking::create([
            'user_id' => 1,
            'field_id' => 1,
            'schedule_id' => 2,
            'status' => 'confirmed',
            'payment_status' => true,
            'price' => 50,
        ]);
    }
}

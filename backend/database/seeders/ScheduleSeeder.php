<?php

namespace Database\Seeders;

use App\Models\Schedule;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ScheduleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Schedule::insert([
            ['field_id' => 1, 'date' => now()->toDateString(), 'start_time' => '08:00', 'end_time' => '10:00', 'is_booked' => false],
            ['field_id' => 1, 'date' => now()->toDateString(), 'start_time' => '10:00', 'end_time' => '12:00', 'is_booked' => true],
            ['field_id' => 2, 'date' => now()->addDay()->toDateString(), 'start_time' => '09:00', 'end_time' => '11:00', 'is_booked' => false],
        ]);
    }
}

<?php

namespace Database\Seeders;

use App\Models\Sport;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class SportSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Sport::insert([
            ['name' => 'Football'],
            ['name' => 'Tennis'],
            ['name' => 'Basketball'],
            ['name' => 'Volleyball'],
            ['name' => 'Badminton'],
        ]);
    }
}

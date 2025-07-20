<?php

namespace Database\Seeders;

use App\Models\Field;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class FieldSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Field::insert([
            ['venue_id' => 1, 'name' => 'Field A', 'sport_id' => 1, 'price_per_hour' => 25],
            ['venue_id' => 1, 'name' => 'Field B', 'sport_id' => 1, 'price_per_hour' => 20],
            ['venue_id' => 2, 'name' => 'Main Field', 'sport_id' => 1, 'price_per_hour' => 30],
        ]);
    }
}

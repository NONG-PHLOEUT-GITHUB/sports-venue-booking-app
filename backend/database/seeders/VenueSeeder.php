<?php

namespace Database\Seeders;

use App\Models\Venue;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class VenueSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Venue::insert([
            ['name' => 'Olympic Stadium', 'location' => 'Phnom Penh', 'description' => 'National multi-sport stadium'],
            ['name' => 'Football Arena', 'location' => 'Siem Reap', 'description' => 'Outdoor football field'],
        ]);
    }
}

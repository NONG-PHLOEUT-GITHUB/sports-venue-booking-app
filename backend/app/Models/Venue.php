<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Venue extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'location', 'description'];

    public function fields()
    {
        return $this->hasMany(Field::class);
    }

    public function schedules()
    {
        return $this->hasMany(Schedule::class);
    }
}

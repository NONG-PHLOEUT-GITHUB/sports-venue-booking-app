<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Sport extends Model
{
    use HasFactory;

    protected $fillable = ['nmae'];

    // public function field()
    // {
    //     return $this->belongsTo(Field::class);
    // }
}

<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class ChangePasswordController extends Controller
{
    public function update(Request $request)
    {
        // Get authenticated user via JWT
        $user = $request->user();

        if (!$user) {
            return response()->json(['message' => 'Unauthorized'], 401);
        }

        // Validate input
        $validated = $request->validate([
            'current_password' => 'required|string',
            'password' => 'required|string|min:6|confirmed', // needs password_confirmation
        ]);

        // Check current password
        if (!Hash::check($validated['current_password'], $user->password)) {
            return response()->json(['message' => 'Current password is incorrect'], 422);
        }

        // Update password
        $user->password = Hash::make($validated['password']);
        $user->save();

        return response()->json(['message' => 'Password changed successfully']);

    }
}

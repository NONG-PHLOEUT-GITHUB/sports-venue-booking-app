<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Tymon\JWTAuth\Facades\JWTAuth;
use Kreait\Firebase\Auth as FirebaseAuth;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name'     => 'required|string|max:255',
            'email'    => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $user = User::create([
            'name'     => $request->name,
            'email'    => $request->email,
            'password' => Hash::make($request->password),
        ]);

        $token = JWTAuth::fromUser($user); // ✅ No Intelephense warning

        return $this->respondWithToken($token);
    }

    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email'    => 'required|string|email',
            'password' => 'required|string',
        ]);

        $credentials = $request->only(['email', 'password']);

        if (! $token = JWTAuth::attempt($credentials)) { // ✅ No Intelephense warning
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        return $this->respondWithToken($token);
    }

    public function me()
    {
        // dd(JWTAuth::user()); // ✅ No Intelephense warning
        return response()->json(JWTAuth::user()); // ✅
    }

    public function logout()
    {
        JWTAuth::invalidate(JWTAuth::getToken());
        return response()->json(['message' => 'Successfully logged out']);
    }

    public function refresh()
    {
        return $this->respondWithToken(JWTAuth::refresh());
    }

    protected function respondWithToken($token)
    {
        return response()->json([
            'access_token' => $token,
            'token_type'   => 'bearer',
            'expires_in'   => JWTAuth::factory()->getTTL() * 60
        ]);
    }

    // public function socialLogin(Request $request)
    // {
    //     $idToken = $request->input('id_token');

    //     // Verify token with Google
    //     $client = new \Google_Client(['client_id' => env('GOOGLE_CLIENT_ID')]);
    //     $payload = $client->verifyIdToken($idToken);

    //     if (!$payload) {
    //         return response()->json(['error' => 'Invalid Google token'], 401);
    //     }

    //     $user = User::firstOrCreate(
    //         ['email' => $payload['email']],
    //         ['name' => $payload['name']]
    //     );

    //     $token = JWTAuth::fromUser($user);

    //     return response()->json([
    //         'access_token' => $token,
    //         'token_type' => 'bearer',
    //         'user' => $user,
    //     ]);
    // }
}

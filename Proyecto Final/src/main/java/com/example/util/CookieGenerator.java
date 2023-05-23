package com.example.util;
import java.util.UUID;
public class CookieGenerator {
    public static String generateSessionToken() {
        // Generar un identificador único (UUID)
        UUID uuid = UUID.randomUUID();
        String sessionToken = uuid.toString();
        return sessionToken;
    }
}


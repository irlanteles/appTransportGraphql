package middleware

import (
	"crypto/rsa"
	"fmt"
	"net/http"
	"os"
	"strings"

	"github.com/golang-jwt/jwt/v5"
)

var publicKey *rsa.PublicKey

// LoadPublicKey lê a chave pública do arquivo
func LoadPublicKey(path string) error {
	keyData, err := os.ReadFile(path)
	if err != nil {
		return fmt.Errorf("não foi possível ler o arquivo da chave pública: %v", err)
	}

	key, err := jwt.ParseRSAPublicKeyFromPEM(keyData)
	if err != nil {
		return fmt.Errorf("não foi possível fazer parse da chave pública: %v", err)
	}

	publicKey = key
	return nil
}

// AuthMiddleware intercepta as requisições e valida o token JWT
func AuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Pega o header Authorization
		authHeader := r.Header.Get("Authorization")
		if authHeader == "" {
			http.Error(w, "Authorization header não fornecido", http.StatusUnauthorized)
			return
		}

		// Verifica se começa com Bearer
		parts := strings.Split(authHeader, " ")
		if len(parts) != 2 || strings.ToLower(parts[0]) != "bearer" {
			http.Error(w, "Formato de token inválido. Use: Bearer <token>", http.StatusUnauthorized)
			return
		}

		tokenString := parts[1]

		// Realiza o parse e validação do token
		token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
			// Valida o método de assinatura esperado
			if _, ok := token.Method.(*jwt.SigningMethodRSA); !ok {
				return nil, fmt.Errorf("método de assinatura inesperado: %v", token.Header["alg"])
			}
			return publicKey, nil
		})

		if err != nil || !token.Valid {
			http.Error(w, "Token inválido ou expirado", http.StatusUnauthorized)
			return
		}

		// (Opcional) Poderíamos extrair claims aqui e injetar no contexto
		// claims, ok := token.Claims.(jwt.MapClaims)
		// se ok ... context.WithValue(...)

		next.ServeHTTP(w, r.WithContext(r.Context()))
	})
}

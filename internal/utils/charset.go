package utils

import (
	"unicode/utf8"

	"golang.org/x/text/encoding/charmap"
)

// ToUTF8 converte uma string de Windows-1252 / ISO-8859-1 para UTF-8.
// Isso resolve o problema de caracteres estranhos (como ) vindos de 
// bancos de dados que não são UTF-8 nativamente (ex: SQL_ASCII).
func ToUTF8(s string) string {
	if s == "" {
		return s
	}

	// Se a string já for um UTF-8 válido (por exemplo, se conter apenas ASCII),
	// não precisamos converter.
	if utf8.ValidString(s) {
		return s
	}

	dec := charmap.Windows1252.NewDecoder()
	out, err := dec.String(s)
	if err != nil {
		return s
	}
	return out
}

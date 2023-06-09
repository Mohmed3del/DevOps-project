package main

import (
	"encoding/json"
	"net/http"
	"strconv"
	"time"
)

func main() {
	http.ListenAndServe(":9090", &handler{})
}

type handler struct {
}

type row struct {
	id        int64
	createdAt time.Time
}

func (h *handler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	if r.URL.Path == "/healthcheck" {
		w.WriteHeader(200)
		w.Write([]byte(`{"status":"ok"}`))
		return
	}
	switch r.Method {
	case "GET":
		rs, err := _connection.Query(`SELECT id,created_at FROM stuff`)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			w.Write([]byte("Internal Server Error"))
			return
		}

		var ret []row
		for rs.Next() {
			cur := row{}
			err = rs.Scan(
				&cur.id,
				&cur.createdAt,
			)

			if err != nil {
				w.WriteHeader(http.StatusInternalServerError)
				w.Write([]byte("Internal Server Error"))
				return
			}

			ret = append(ret, cur)
		}

		bs, err := json.Marshal(ret)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			w.Write([]byte("Internal Server Error"))
			return
		}
		_, err = w.Write(bs)
		if err != nil {
			panic(err)
		}
	case "POST":
		_, err := _connection.Exec("INSERT INTO stuff (created_at) VALUES (NOW())")
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			w.Write([]byte("Internal Server Error"))
			return
		}
		w.Write([]byte(`OK`))
	case "PATCH":
		idStr := r.URL.Query().Get("id")
		id, err := strconv.ParseInt(idStr, 10, 64)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			w.Write([]byte("Invalid id value"))
			return
		}

		_, err = _connection.Exec(`UPDATE stuff SET created_at=NOW() WHERE id=?`, id)
		if err != nil {
			w.WriteHeader(http.StatusInternalServerError)
			return
		}

		w.Write([]byte(`OK`))
	}
}

package main

import (
	"net/http"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Routes
	e.GET("/:param", hello)
	e.GET("/", helloip)

	// Start server
	e.Logger.Fatal(e.Start(":1323"))
}

// Handler
func hello(c echo.Context) error {
	var param = new(string)
	*param = c.Param("param")
	return c.String(http.StatusOK, "Hello, "+*param+"!")
}

func helloip(c echo.Context) error {
	var param = new(string)
	*param = c.RealIP()
	return c.String(http.StatusOK, "Hello, "+*param+"!")
}


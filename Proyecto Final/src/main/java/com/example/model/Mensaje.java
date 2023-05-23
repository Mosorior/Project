package com.example.model;

public class Mensaje {
    private int id;
    private String titulo;
    private String contenido;
    private String fecha;
    private String usuario;
    private int aceptado;
    private String sessionToken;
    private String telefono;

    public Mensaje(int id, String titulo, String contenido, String fecha, String usuario, int aceptado, String sessionToken) {
        this.id = id;
        this.titulo = titulo;
        this.contenido = contenido;
        this.fecha = fecha;
        this.usuario = usuario;
        this.aceptado = aceptado;
        this.sessionToken = sessionToken;
    }

    public int getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getContenido() {
        return contenido;
    }

    public String getFecha() {
        return fecha;
    }

    public String getUsuario() {
        return usuario;
    }

    public int getAceptado() {
        return aceptado;
    }

    public String getSessionToken() {
        return sessionToken;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public boolean isRechazado() {
        return aceptado == 0;
    }
}

package com.potmain;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Controlador;
import models.Pedido;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/Admin/grafico")
public class grafico extends HttpServlet{
    private final int CANTIDAD_ESTADOS = 4;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Controlador controlador = new Controlador();
        ArrayList<Pedido> pedidos = controlador.getTodosPedidos();
        int[] estados = new int[CANTIDAD_ESTADOS];

        for(Pedido pedido : pedidos){
            estados[pedido.getEstado()]++;
        }

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        String json = new Gson().toJson(estados);
        out.println(json);
        out.flush();
    }
}

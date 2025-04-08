<%-- 
    Document   : index
    Created on : 8 abr 2025, 11:59:47 a. m.
    Author     : erick
--%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Conversor de Monedas</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background-color: #f9f9f9; }
        .container { max-width: 500px; margin: auto; padding: 20px; background-color: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .result, .error { margin-top: 20px; padding: 10px; border-radius: 5px; }
        .result { background-color: #e0f7fa; color: #006064; }
        .error { background-color: #ffebee; color: #c62828; }
    </style>
    
</head>
<body>
<div class="container">
    <h1>Conversor de Colones (CRC)</h1>
    <form>
        <label for="colones">Cantidad en colones:</label><br>
        <input type="number" id="colones" name="colones" value="<%= request.getParameter("colones") != null ? request.getParameter("colones") : "" %>"><br><br>
        <!-- cambie el type text a number y ahora solo va a admitir numeros -->
        <label>Moneda de destino:</label><br>
        <input type="radio" id="usd" name="moneda" value="USD" <%= "USD".equals(request.getParameter("moneda")) ? "checked" : "" %>>
        <label for="usd">Dólares (USD)</label><br>
        <input type="radio" id="eur" name="moneda" value="EUR" <%= "EUR".equals(request.getParameter("moneda")) ? "checked" : "" %>>
        <label for="eur">Euros (EUR)</label><br><br>

        <input type="submit" value="Convertir">
    </form>

<%
    //se una final para asignarle el mismo valor y no cambie 
    final double monedaUSD = 540.0;
    final double monedaEUR = 580.0;

    // se enviado desde el formulario con el nombre colones y lo 
    //guarda en la variable colonesv como un String
    String colonesV = request.getParameter("colones");
    //lo mismo que el anterior pero este solo guarda la opcion de USD o EUR
    String moneda = request.getParameter("moneda");
    // y los dos request solo es para optener los datos que uno ingresa para el formulario
    
    //este if solo verifica si los parametros se pusieron o se eligio para que no de null
    if (colonesV != null) {
        if (moneda == null) {// este if es para hacegurar de que escogan una opcion de las dos 
%>
            <div class="error">Por favor, seleccione una moneda </div>
<%          // mensaje de error al no escoger la moneda
    
        } else {
            //este try es el que es para convetir  colonesV que es String a decimal y guardarlo en colones
            try {
                double colones = Double.parseDouble(colonesV);
                if (colones <= 0) {// este spñp es para verifar que sea mayor a 0
%>
                    <div class="error">La cantidad debe ser mayor que cero.</div>
<%
                } else {//para hacer la convercion de la moneda
                    double resultado = moneda.equals("USD") ? colones / monedaUSD : colones / monedaEUR;
                    DecimalFormat df = new DecimalFormat("#.##");
%>
                    <div class="result">
                        <strong>Resultado:</strong> <%= df.format(colones) %> CRC = <%= df.format(resultado) %> <%= moneda %>
                        </div>
<%
                }
            } catch (NumberFormatException e) { // si el campo rellenado no es un numero va a ejecutar el error
%>
                <div class="error">Debe ingresar un número válido.</div>
<%          // si no se coloca un numero le va a aparecer que ese campo es invalido en el campo de colones
            }
        }
    }
%>

</div>
</body>
</html>

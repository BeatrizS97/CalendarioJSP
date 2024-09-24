<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Calendário</title>
    <style>
        table {
            border-collapse: collapse;
            width: 50%;
        }
        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>Calendário do Mês</h2>
    <form method="get" action="calendario.jsp">
        Ano: <input type="text" name="ano" value="<%= request.getParameter("ano") != null ? request.getParameter("ano") : "" %>" /> <!<!-- Trata-se de um campo de entrada que vai permitir que o usuário insira o ano e o mês, de modo que o valor preenchido será enviado previamento pelo usuário. -->
        Mês: <input type="text" name="mes" value="<%= request.getParameter("mes") != null ? request.getParameter("mes") : "" %>" />
        <input type="submit" value="Gerar Calendário" />
    </form>
    
    <%
        // Serve para capturar os parâmetros do ano e mês
        String anoParam = request.getParameter("ano");
        String mesParam = request.getParameter("mes");
        
        
        // Serve para verificar se os parâmetros recebidos pelo servidor e enviados pelo usuário, estão corretos e não estão nulos.
        if (anoParam != null && mesParam != null) {
            try {
                int ano = Integer.parseInt(anoParam);
                int mes = Integer.parseInt(mesParam) - 1; // Nesse caso o mês vai de 0 (Janeiro) a 11 (Dezembro)

                // Serve para criar a instância do calendário
                java.util.Calendar calendario = java.util.Calendar.getInstance();
                calendario.set(ano, mes, 1);
                
                // Serve para obter o primeiro dia da semana (Domingo=1, Segunda=2, etc.)
                int primeiroDiaSemana = calendario.get(java.util.Calendar.DAY_OF_WEEK);
                int diasNoMes = calendario.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

                // Imprime o calendário
    %>
                <table>
                    <tr>
                        <th>Dom</th>
                        <th>Seg</th>
                        <th>Ter</th>
                        <th>Qua</th>
                        <th>Qui</th>
                        <th>Sex</th>
                        <th>Sáb</th>
                    </tr>
                    <tr>
                        <%
                            // Serve para imprimir os dias vazios antes do primeiro dia do mês
                            for (int i = 1; i < primeiroDiaSemana; i++) {
                                out.print("<td></td>");
                            }

                            // Serve para imprimir os dias do mês
                            for (int dia = 1; dia <= diasNoMes; dia++) {
                                out.print("<td>" + dia + "</td>");
                                
                                // Ele tem a função de quebrar linha após o sábado
                                if ((dia + primeiroDiaSemana - 1) % 7 == 0) {
                                    out.print("</tr><tr>");
                                }
                            }

                            // Serve para completar a última semana com células vazias, se necessário
                            int ultimoDiaSemana = (diasNoMes + primeiroDiaSemana - 1) % 7;
                            for (int i = ultimoDiaSemana + 1; i <= 7 && ultimoDiaSemana != 0; i++) {
                                out.print("<td></td>");
                            }
                        %>
                    </tr>
                </table>
    <%
            } catch (NumberFormatException e) {
                out.println("<p>Erro: O ano e o mês devem ser números válidos.</p>");
            }
        }
    %>
</body>
</html>
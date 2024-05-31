<%-- 
    Document   : ProdutoLista
    Created on : May 31, 2024, 1:21:04 PM
    Author     : luisf
--%>

<%@page import="cadastroee.model.Produto"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Produtos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body{
            margin-top: 40px; 
            background-color: #212529;
            color: #fff;
        }
        .header {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            padding-right: 10px;
            align-items: center;
        }
    </style>
</head>
<body class="container">
    <div class="header">
        <h1>Listagem de Produtos</h1>
        <div>
            <a class="btn btn-info btn-sm" href="ServletProdutoF?acao=formIncluir">Novo Produto</a>
        </div>
    </div>
    
        
    <table class="table table-dark table-hover">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Quantidade</th>
            <th>Preço de Venda</th>
            <th>Opções</th>
        </tr>
        <% 
            List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
            if (produtos != null) {
                for (Produto produto : produtos) {
        %>
        <tr>
            <td><%= produto.getIdProduto() %></td>
            <td><%= produto.getNome() %></td>
            <td><%= produto.getQuantidade() %></td>
            <td><%= produto.getPrecoVenda() %></td>
            <td>
                <a class="btn btn-primary btn-sm" href="ServletProdutoF?acao=formAlterar&id=<%=produto.getIdProduto()%>">Alterar</a>
                <a class="btn btn-danger btn-sm" ref="ServletProdutoF?acao=excluir&id=<%=produto.getIdProduto()%>">Excluir</a>
            </td>
        </tr>
        <% 
                }
            }
        %>
    </table>
    
</body>
</html>






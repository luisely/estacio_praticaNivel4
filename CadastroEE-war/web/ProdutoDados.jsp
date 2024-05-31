<%-- 
    Document   : ProdutoDados
    Created on : May 31, 2024, 2:06:15 PM
    Author     : luisf
--%>

<%@page import="cadastroee.model.Produto"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <title>Cadastro de Produtos</title>
    <style> 
        body{
            margin-top: 40px; 
            background-color: #212529;
            color: #fff;
        }
    </style>
</head>
<body class="container">
    <%
        Produto produto = (Produto) request.getAttribute("produto");
        String acao = produto != null ? "alterar" : "incluir";
    %>

    <div>
        <h1><%=acao.equals("alterar") ? "Dados" : "Inclusão"%> do Produto</h1>
    </div>
   
        <div class="row">
        <form class="form" action="ServletProdutoF" method="post">
            <div class="col-4">
                <input type="hidden" name="acao" value="<%=acao%>">

                <% if (acao.equals("alterar")) { %>
                    <input type="hidden" name="id" value="<%=produto.getIdProduto()%>">
                <% } %>

                <div class="mb-3">
                    <label class="form-label" for="nome">Nome</label>
                    <input class="form-control" type="text" name="nome" value="<%=produto != null ? produto.getNome() : ""%>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label" for="quantidade">Quantidade</label>
                    <input class="form-control" type="text" name="quantidade" value="<%=produto != null ? produto.getQuantidade() : ""%>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label" for="preco">Preço de Venda</label>
                    <input class="form-control" type="text" name="preco" value="<%=produto != null ? produto.getPrecoVenda() : ""%>" required>
                </div>

                <div>
                    <input class="btn btn-primary" type="submit" value="<%=acao.equals("incluir") ? "Incluir" : "Alterar"%>">
                </div>
            </div>
        </form>
        </div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</html>

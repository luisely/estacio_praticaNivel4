/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package cadastroee.servlets;

import cadastroee.controller.ProdutoFacadeLocal;
import cadastroee.model.Produto;
import jakarta.ejb.EJB;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author luisf
 */
@WebServlet(name = "ServletProdutoF", urlPatterns = {"/ServletProdutoF"})
public class ServletProdutoF extends HttpServlet {

    @EJB
    private ProdutoFacadeLocal facade;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        
        if (acao == null || acao.isEmpty()) {
            acao = "listar";
        }
        
        switch (acao) {
            case "excluir":
                excluirProdutos(request, response);
                break;
            case "formAlterar":
                formAlterar(request, response);
                break;
            case "formIncluir":
                formIncluir(request, response);
                break;
            default:
                listarProdutos(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String acao = request.getParameter("acao");
        
        if (acao != null && !acao.isEmpty()) {
            switch (acao) {
                case "incluir":
                    incluirProdutos(request, response);
                    break;
                case "alterar":
                    alterarProdutos(request, response);
                    break;
            }
        } else {
            response.sendRedirect("ServletProdutoF");
        }
    }

    private void excluirProdutos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idExcluir = Integer.parseInt(request.getParameter("id"));
            facade.remove(facade.find(idExcluir));
            response.sendRedirect("ServletProdutoF");
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void listarProdutos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Produto> produtos = facade.findAll();
        
        request.setAttribute("produtos", produtos);
        RequestDispatcher dispatcher = request.getRequestDispatcher("ProdutoLista.jsp");
        dispatcher.forward(request, response);
    }

    private void formAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idAlterar = Integer.parseInt(request.getParameter("id"));
            Produto produto = facade.find(idAlterar);
            request.setAttribute("produto", produto);
            RequestDispatcher dispatcher = request.getRequestDispatcher("ProdutoDados.jsp");
            dispatcher.forward(request, response);
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void alterarProdutos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Produto produtoModificado = facade.find(id);
            produtoModificado.setNome(request.getParameter("nome"));
            produtoModificado.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
            produtoModificado.setPrecoVenda(Float.valueOf(request.getParameter("preco")));

            facade.edit(produtoModificado); 
            response.sendRedirect("ServletProdutoF");
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    private void formIncluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("ProdutoDados.jsp");
        dispatcher.forward(request, response);
    }

    private void incluirProdutos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String nome = request.getParameter("nome");

            Produto novoProduto = new Produto();
            novoProduto.setNome(nome);
            novoProduto.setQuantidade(Integer.parseInt(request.getParameter("quantidade")));
            novoProduto.setPrecoVenda(Float.valueOf(request.getParameter("preco")));

            facade.create(novoProduto);
            response.sendRedirect("ServletProdutoF");
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
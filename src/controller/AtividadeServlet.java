package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persistence.AtividadeDao;
import persistence.IAtividadeDao;
import model.Aluno;
import model.AtividadesAlunos;

@WebServlet("/cadastroatividade")
public class AtividadeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AtividadeServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String erro = "";
		String codigoAluno = request.getParameter("codigoaluno");
		String nomeAluno = request.getParameter("nomealuno");
		String alturaAluno = request.getParameter("alturaaluno");
		String pesoAluno = request.getParameter("pesoaluno");
		double altura = Double.parseDouble(alturaAluno);
		double peso = Double.parseDouble(pesoAluno);
		Aluno al = new Aluno();
		if (!codigoAluno.trim().equals("")){
			al.setCodigo(Integer.parseInt(codigoAluno));
		}
		if (!nomeAluno.trim().equals("")){
			al.setNome(nomeAluno);
		}
		AtividadesAlunos aa = new AtividadesAlunos();
		aa.setAluno(al);
		aa.setAltura(altura);
		aa.setPeso(peso);
		IAtividadeDao aDao = new AtividadeDao();
		try {
			al = aDao.insereAtividade(aa);
			aa = aDao.consultaAtividade(al);
		} catch (SQLException e) {
			erro = e.getMessage();
		} finally {
			request.setAttribute("erro", erro);
			request.setAttribute("alunoatividade", aa);
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}

}

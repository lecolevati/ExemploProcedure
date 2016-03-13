package persistence;

import java.sql.SQLException;

import model.Aluno;
import model.AtividadesAlunos;

public interface IAtividadeDao {

	public Aluno insereAtividade(AtividadesAlunos aa) throws SQLException;
	public AtividadesAlunos consultaAtividade(Aluno al) throws SQLException;
	
}

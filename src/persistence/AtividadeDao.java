package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;

import model.Aluno;
import model.Atividade;
import model.AtividadesAlunos;

public class AtividadeDao implements IAtividadeDao {

	private Connection c;
	
	public AtividadeDao() {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	@Override
	public AtividadesAlunos consultaAtividade(Aluno al) throws SQLException {
		AtividadesAlunos aa = new AtividadesAlunos();
		StringBuffer sql = new StringBuffer(); 
		sql.append("SELECT al.codigo, al.nome, aa.altura, aa.peso, ");
		sql.append("aa.imc, ativ.descricao ");
		sql.append("FROM aluno al ");
		sql.append("INNER JOIN atividadesaluno aa ");
		sql.append("ON aa.codigo_aluno = al.codigo ");
		sql.append("INNER JOIN atividade ativ ");
		sql.append("ON aa.atividade = ativ.codigo ");
		sql.append("WHERE al.codigo = ?");
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setInt(1, al.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()){
			aa.setAltura(rs.getDouble("altura"));
			aa.setPeso(rs.getDouble("peso"));
			aa.setImc(rs.getDouble("imc"));
			al.setNome(rs.getString("nome"));
			aa.setAluno(al);
			Atividade ativ = new Atividade();
			ativ.setDescricao(rs.getString("descricao"));
			aa.setAtividade(ativ);
		}
		rs.close();
		ps.close();
		return aa;
	}

	@Override
	public Aluno insereAtividade(AtividadesAlunos aa) throws SQLException {
		Aluno al = new Aluno();
		String sqlProc = "{call sp_alunoatividades(?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sqlProc);
		if (aa.getAluno().getCodigo() == 0){
			cs.setNull(1, Types.INTEGER);
		} else {
			cs.setInt(1, aa.getAluno().getCodigo());	
		}
		if (aa.getAluno().getNome() == null){
			cs.setNull(2, Types.VARCHAR);
		} else {
			cs.setString(2, aa.getAluno().getNome());
		}
		cs.setDouble(3, aa.getAltura());
		cs.setDouble(4, aa.getPeso());
		cs.registerOutParameter(5, Types.INTEGER);
		cs.execute();
		al.setCodigo(cs.getInt(5));
		String sqlSelect = "SELECT nome FROM aluno WHERE codigo = ?";
		PreparedStatement ps = c.prepareStatement(sqlSelect);
		ps.setInt(1, al.getCodigo());
		ResultSet rs = ps.executeQuery();
		if (rs.next()){
			al.setNome(rs.getString("nome"));
		}
		cs.close();
		rs.close();
		ps.close();
		return al;
	}

}

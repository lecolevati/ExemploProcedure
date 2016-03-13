<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Exemplo Procedure</title>
</head>
<body>
	<div id="cadastro" align="center">
		<form action="cadastroatividade" method="post">
			<table>
				<thead>
					<tr>
						<th colspan="2">Atividade Aluno</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Código Aluno</td>
						<td><input type="text" name="codigoaluno"></td>
					</tr>
					<tr>
						<td>Nome Aluno</td>
						<td><input type="text" name="nomealuno" style="width: 300px"></td>
					</tr>
					<tr>
						<td>Altura</td>
						<td><input type="number" step="any" min="0"
							name="alturaaluno" required="required" style="width: 50px"></td>
					</tr>
					<tr>
						<td>Peso</td>
						<td><input type="number" step="any" min="0" name="pesoaluno"
							required="required" style="width: 50px"></td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit"
							name="Cadastro" value="Cadastro"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div id="lista" align="center">
		<c:if test="${empty erro }">
			<c:if test="${not empty alunoatividade }">
				<table border="1">
					<thead>
						<tr>
							<th>Código</th>
							<th>Nome</th>
							<th>Altura</th>
							<th>Peso</th>
							<th>IMC</th>
							<th>Atividade</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><c:out value="${alunoatividade.aluno.codigo }" /></td>
							<td><c:out value="${alunoatividade.aluno.nome }" /></td>
							<td><c:out value="${alunoatividade.altura }" /></td>
							<td><c:out value="${alunoatividade.peso }" /></td>
							<td><c:out value="${alunoatividade.imc }" /></td>
							<td><c:out value="${alunoatividade.atividade.descricao }" /></td>
						</tr>
					</tbody>
				</table>
			</c:if>
		</c:if>
		<c:if test="${not empty erro }">
			<h2>
				<c:out value="${erro }" />
			</h2>
		</c:if>
	</div>
</body>
</html>
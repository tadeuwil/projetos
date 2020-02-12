//Criado em 11/02/2002 - Por Tadeu Wilson
//Essa tela vai testar o programa: Salvando, Removendo e Listando os dados.

import java.util.List;

public class Teste {

	public static void main(String[] args) {
		aluno a1 = new aluno();
		a1.setNome("João Silva");
		a1.setIdade(18);
		a1.setMatricula("123456789");
		
		aluno a2 = new aluno();
		a2.setNome("Tadeu Wilson");
		a2.setIdade(38);
		a2.setMatricula("123456779");
		
		aluno a3 = new aluno();
		a3.setNome("Rayane Silva");
		a3.setIdade(24);
		a3.setMatricula("123456889");
		
		AlunoController com = new AlunoController();
		
//Para Salvar os dados no banco deverá remover os itens comentados abaixo.
		
		//com.salvar(a1);
		//com.salvar(a2);
		//com.salvar(a3);
		
//Para Remover os dados deverá teriar os itens comentados abaixo.
		
		//com.remover(a1);
		//com.remover(a2);
		//com.remover(a3);
		
		List<aluno> al = com.listar();
		
		for(int i = 0; i < al.size(); i++){
			System.out.print("Nome: "+al.get(i).getNome() + " - Idade: "+al.get(i).getIdade() + " - Matricula: "+al.get(i).getMatricula());
		}

	}

}

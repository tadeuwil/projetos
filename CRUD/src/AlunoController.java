//Criado em 11/02/2002 - Por Tadeu Wilson
//Essa tela vai testar o programa: Salvando, Removendo e Listando os dados.


import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

public class AlunoController {
	EntityManagerFactory emf;
	EntityManager em;
	
	
	public AlunoController() {
		emf = Persistence.createEntityManagerFactory("aluno");
		em = emf.createEntityManager();		
	}
	
	public void salvar(aluno _aluno) {
		em.getTransaction().begin();
		em.merge(_aluno);
		em.getTransaction().commit();
		emf.close();
		
	}
	
	public void remover(aluno _aluno) {
		em.getTransaction().begin();
		Query q = em.createNativeQuery("delete aluno from aluno where matricula ="+_aluno.getMatricula());
		q.executeUpdate();
		em.getTransaction().commit();
		emf.close();
		
	}
	
	public List<aluno> listar(){
		em.getTransaction().begin();
		Query consulta = em.createQuery("SELECT aluno FROM aluno aluno");
		List<aluno> lista = consulta.getResultList();
		em.getTransaction().commit();
		emf.close();
		return lista;
		
	}

}

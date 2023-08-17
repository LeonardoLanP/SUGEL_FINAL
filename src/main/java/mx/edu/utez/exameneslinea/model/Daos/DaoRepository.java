package mx.edu.utez.exameneslinea.model.Daos;

import java.util.List;

public interface DaoRepository<T>{
    List<T> findAll();
    T findOne(int id);

    boolean update(int id, T object);

    boolean delete(int id);
}

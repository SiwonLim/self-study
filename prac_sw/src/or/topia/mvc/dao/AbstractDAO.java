package or.topia.mvc.dao;

import java.util.ArrayList;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sun.tools.javac.util.List;

@Repository
public class AbstractDAO {
	protected Log log = LogFactory.getLog(AbstractDAO.class);
	@Autowired
	private SqlSessionTemplate ss;
	
	//Äõ¸®¹® Ã¼Å©
	protected void printQueryiD(String queryId) {
		if(log.isDebugEnabled()){
			log.debug("\t QueryId \t : "+ queryId);
		}
	}
	
	//db
	@SuppressWarnings("rawtypes")
	public ArrayList<Object> selectList(String queryId, Object params) {
		printQueryiD(queryId);
		return (ArrayList<Object>) ss.selectList(queryId,params);
	}
}

package or.topia.mvc.dao;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AbstractDAO {
	protected Log log = LogFactory.getLog(AbstractDAO.class);
	
	@Autowired
	private SqlSessionTemplate ss;
	protected void printQeuryId(String queryId)
	{
		if(log.isDebugEnabled())
			log.debug("\t QueryId \t"+queryId);
	}
	//insert
	public void insert(String queryId, Object param)
	{
		printQeuryId(queryId);
		ss.insert(queryId,param);
	}
}

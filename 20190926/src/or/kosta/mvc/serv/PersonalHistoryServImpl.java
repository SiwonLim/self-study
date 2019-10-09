package or.kosta.mvc.serv;
import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PersonalHistoryServImpl implements PersonalHistoryServ{
	
	@Autowired
	private SqlSessionTemplate ss;
	@Override
	public HashMap<String, Object> userList() {
		// TODO Auto-generated method stub
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		ArrayList<Object> list;
		try {
			list=(ArrayList<Object>)ss.selectList("member.map_getMembers");
			resMap.put("list", list);
		} catch (Exception e) {
			// TODO: handle exception
			e.getStackTrace();
		}
		return resMap;
	}
}

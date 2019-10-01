package or.topia.mvc.serv;

import java.awt.List;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import or.topia.mvc.dao.AbstractDAO;
@Service
public class PersonalHistoryServImpl implements PersonalHistoryServ{
	
	@Autowired
	AbstractDAO dbCon;
	
	@Override
	public HashMap<String,Object> userList(HashMap<String, Object> reqMap){
		HashMap<String,Object> resMap = new HashMap<String, Object>();
		//dao-db값을 불러온다
		ArrayList<Object> list = new ArrayList<Object>();
		try {
			list = (ArrayList<Object>)dbCon.selectList("personalHistory.userList", reqMap);
			System.out.println("size.."+list.size());
			resMap.put("list", list);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resMap;
	}
}

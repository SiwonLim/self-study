package or.topia.mvc.serv;

import java.util.HashMap;

public interface PersonalHistoryServ {
	//mybatis-map 사용을 위해서
	public HashMap<String,Object> userList(HashMap<String, Object> reqMap);
}

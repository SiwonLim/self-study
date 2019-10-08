package or.topia.mvc.serv;

import java.util.HashMap;

public interface PersonalHistoryServ {
	public HashMap<String, Object> userList(HashMap<String, Object> reqMap);
	public HashMap<String, Object> registerUser(Object inputdata);
}

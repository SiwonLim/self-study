package or.topia.mvc;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import or.topia.mvc.serv.PersonalHistoryServImpl;

@Controller
public class MainController {
	@Autowired
	private PersonalHistoryServImpl serv;
	
	@RequestMapping(value= {"/","/index"})
	public String index()
	{
		return "index";
	}
	//interface 있으면 @Override붙여주기..
	@RequestMapping("/getData")
	@ResponseStatus(value = HttpStatus.OK)//예외처리 담당
	@ResponseBody//jsp에 결과값 리턴
	public HashMap<String, Object> getData()
	{
		System.out.println("!!");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String,Object> unlockRedMap = new HashMap<String, Object>();

		/*Set set = m.entrySet();
		Iterator it = set.iterator();
		while(it.hasNext())
		{
			Map.Entry entry = (Map.Entry)it.next();
			String key = (String)entry.getKey();
			String value=(String)entry.getValue();
			System.out.println(key+".."+value);
			unlockRedMap.put(key, value);
		}*/
		unlockRedMap.put("0", "1");
		try {
			resultMap = (HashMap<String,Object>)serv.userList(unlockRedMap);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return resultMap;
	}
}

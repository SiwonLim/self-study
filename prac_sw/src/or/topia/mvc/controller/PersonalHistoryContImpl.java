package or.topia.mvc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import or.topia.mvc.dao.AbstractDAO;
import or.topia.mvc.serv.PersonalHistoryServImpl;

@Controller
public class PersonalHistoryContImpl implements PersonalHistoryCont{
	
	@Autowired
	private PersonalHistoryServImpl serv;
	@Autowired
	private AbstractDAO dao;
	
	@Override
	@RequestMapping(value="/personalHistory/registerUser",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> registerUser(@RequestBody Map<String, Object> params) throws Exception {
		Map<String, Object> resMap = new HashMap<String, Object>();
		Map<String, Object> flexMap = new LinkedHashMap<String, Object>();
		JSONParser parser = new JSONParser();
		Object user_idx="";
		try {
			params.forEach((key,value)->{
				if(key.equals("flexibleTable"))
				{
					try {
						JSONArray array = (JSONArray)parser.parse(String.valueOf(value));
						int size = array.size();
						for(int i = 0 ; i < size ; i++)
						{
							JSONObject obj = (JSONObject)array.get(i);
							String reKey = (String)obj.get("tbName");
							if(flexMap.containsKey(reKey)) reKey += "_"+String.valueOf(i);
							flexMap.put(reKey, obj);
						}
					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
				else
				{
					System.out.print("key : "+key);
					System.out.println(", value : "+value);
				}
			});
			//params에서 고정+동적 한꺼번에 받아왔기에
			//동적 데이터만 삭제
			params.keySet().remove("flexibleTable");
			
			//고정 데이터 insert
			dao.insert("history.registerUser", params);
			//현재 user_idx값 가져오기
			user_idx = params.get("userIdxvalue");
			
			//동적 데이터 insert
			for(Map.Entry<String, Object> entry : flexMap.entrySet())
			{
				Map<String, Object> dbFlexMap = new HashMap<String, Object>();
				dbFlexMap.putAll((Map<String, Object>)entry.getValue());
				dbFlexMap.put("userIdx", user_idx);
				
				System.out.println("key : "+ entry.getKey());
				dbFlexMap.forEach((key1,value1)->{
					System.out.print("key1 : "+key1);
					System.out.println(", value1 : "+value1);
				});
				dao.insert("history.insertUserFlexibleData", dbFlexMap);
				dbFlexMap.clear();
			}
			/* mapper에서 keyProperty 가져오는 방법
			 * resMap.put("userIdx", params.get("userIdxvalue"));
			*/
			//결과상태 resMap에 담아서 return
			resMap.put("userIdx", user_idx);
			resMap.put("errorCode", "");
			resMap.put("errorMsg", "");
		} catch (Exception e) {
			// TODO: handle exception
			resMap.put("userIdx", user_idx);
			resMap.put("errorCode", "PersonalHistoryContImpl.java / "+e.getCause());
			resMap.put("errorMsg", "PersonalHistoryContImpl.java / "+e.getMessage());
		}
		return resMap;
	}
}

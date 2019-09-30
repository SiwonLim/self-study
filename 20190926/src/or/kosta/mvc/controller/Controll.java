package or.kosta.mvc.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import or.kosta.mvc.dao.MemberDAO;
import or.kosta.vo.CoulmnVO;
import or.kosta.vo.MemberVO;
import or.kosta.vo.RegMemberVO;

@Controller
public class Controll {

	@Autowired
	private MemberDAO dao;

	@RequestMapping(value = "/hello", method = RequestMethod.GET)
	public ModelAndView defaultPage() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("sayhello");
		mav.addObject("msg", "안녕하세요?");
		return mav;
	}

	@RequestMapping(value= {"/","/index"})
	public String page() {
		return "index";
	}
	
	@RequestMapping("/home")
	public Object home()
	{
		return "test";
	}

	@RequestMapping("/getColumn")
	@ResponseStatus(value = HttpStatus.OK)//예외처리 담당
	@ResponseBody//jsp에 결과값 리턴
	public Object getColumn()
	{
		List<CoulmnVO> list = new ArrayList<CoulmnVO>();
		list = dao.getColumn();
		//비번은 제외하고 리턴해야됨
		return (Object)list;
	}
	
	@RequestMapping("/delData")
	@ResponseStatus(value = HttpStatus.OK)//예외처리 담당
	@ResponseBody//jsp에 결과값 리턴
	public String delData(int id)
	{
		try {
			dao.delData(id);
			return "ok";
		} catch (Exception e) {
			// TODO: handle exception
			return "error";
		}
	}
	@RequestMapping(value="/editData")
	public ModelAndView editData(int id)
	{
		RegMemberVO vo = dao.getMember(id);
		List<String> s = new ArrayList<String>();
		s.add(Integer.toString(vo.getId()));
		s.add("22");
		s.add(vo.getFirstname());
		s.add(vo.getLastname());
		s.add(vo.getUsername());
		s.add(vo.getEmail());
		s.add(vo.getGender());
		s.add(vo.getMdate());
		ModelAndView m = new ModelAndView("edit");
		m.addObject("data", s);
		return m;
	}
	
	@RequestMapping("/getData")
	@ResponseStatus(value = HttpStatus.OK)//예외처리 담당
	@ResponseBody//jsp에 결과값 리턴
	public Object getData()
	{
		List<RegMemberVO> list = new ArrayList<RegMemberVO>();
		list = dao.getMembers();
		return (Object)list;
	}
	
	@RequestMapping(value="/insert")
	@ResponseStatus(value = HttpStatus.OK)//예외처리 담당
	@ResponseBody//jsp에 결과값 리턴
	public synchronized String insertData(RegMemberVO vo) throws IOException
	{
		String ret="";
		try {
			//date 설정
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			vo.setMdate(f.format(System.currentTimeMillis()));
			System.out.println("!!! " +vo.getMdate());
			//db에 데이터 insert
			ret = dao.insertMember(vo);
			return ret;
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			return ret;
		}
	}
}

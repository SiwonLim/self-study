package or.kosta.mvc.dao;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.support.SQLExceptionSubclassTranslator;
import org.springframework.stereotype.Repository;

import or.kosta.vo.MemberVO;
import or.kosta.vo.RegMemberVO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate ss;

	public List<MemberVO> getList() {
		return ss.selectList("member.getM");
	}

	public void insertData(MemberVO vo) {
		ss.insert("member.insert", vo);
	}

	public String insertMember(RegMemberVO vo)
	{
		try {
			//1.username, email중복검사
			if((int)ss.selectOne("member.chkDup_username",vo.getUsername()) > 0)
				return "dup_username";
			if((int)ss.selectOne("member.chkDup_email",vo.getEmail()) > 0)
				return "dup_email";
			//2.insert
			ss.insert("member.insertMember", vo);
			return "ok";
		} catch (Exception e) {
			// TODO: handle exception
			return "error";
		}
	}

	public List<RegMemberVO> getMembers() {
		return ss.selectList("member.getMembers");
	}
}

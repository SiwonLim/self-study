package or.kosta.mvc.dao;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.support.SQLExceptionSubclassTranslator;
import org.springframework.stereotype.Repository;

import or.kosta.vo.CoulmnVO;
import or.kosta.vo.MemberVO;
import or.kosta.vo.RegMemberVO;

@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate ss;

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
	public void delData(int id) throws DataAccessException
	{
		ss.delete("member.delData",id);
	}
	public List<CoulmnVO> getColumn()
	{
		return ss.selectList("member.getColumn");
	}
	public List<RegMemberVO> getMembers() {
		return ss.selectList("member.getMembers");
	}
	public RegMemberVO getMember(int id)
	{
		return ss.selectOne("member.getData",id);
	}
}

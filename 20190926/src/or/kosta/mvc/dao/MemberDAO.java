package or.kosta.mvc.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import or.kosta.vo.MemberVO;
@Repository
public class MemberDAO {
	@Autowired
	private SqlSessionTemplate ss;
	
	public List<MemberVO> getList()
	{
		return ss.selectList("member.getM");
	}
	public void insertData(MemberVO vo)
	{
		ss.insert("member.insert", vo);
	}
}

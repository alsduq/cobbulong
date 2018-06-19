package first.member.dao;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import first.common.dao.AbstractDAO;

@Repository("memberDAO")
public class MemberDAO extends AbstractDAO{
	Logger log = Logger.getLogger(this.getClass());

	public int selectId(Map<String, Object> map) {
		return (int) selectOne("member.selectId", map);
	}

	public int insertMember(Map<String, Object> map) {
		return (int) insert("member.insertMember", map);
	}

	public String logIn(Map<String, Object> map) {
		return (String) selectOne("member.logIn", map);
	}

	

}

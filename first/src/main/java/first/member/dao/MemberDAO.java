package first.member.dao;

import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import first.common.dao.AbstractDAO;

//@Repository("memberDAO")
@Component("memberDAO")
public class MemberDAO extends AbstractDAO{
	Logger log = Logger.getLogger(this.getClass());

	public int selectId(Map<String, Object> map) {
		return (int) selectOne("member.selectId", map);
	}

	public int insertMember(Map<String, Object> map) {
		return (int) selectOne("member.insertMember", map);
	}

	public String logIn(Map<String, Object> map) {
		return (String) selectOne("member.logIn", map);
	}

	public String findId(Map<String, Object> map) {
		return (String) selectOne("member.findId", map);
	}

	public int confirmAccount(Map<String, Object> map) {
		return (int) selectOne("member.confirmAccount", map);
	}

	public void updateAuthNo(Map<String, Object> map) {
		update("member.updateAuthNo", map);
	}

	public int authNoCheck(Map<String, Object> map) {
		return (int) selectOne("member.selectAuthNo", map);
	}

	public void updatePassword(Map<String, Object> map) {
		update("member.updatePassword", map);
	}

	public int insertLoginLog(Map<String, Object> map) {
		return (int) selectOne("member.insertLoginLog", map);
	}

	public void updateLogOutLog(Map<String, Object> map) {
		update("member.updateLogOutLog", map);
	}

}

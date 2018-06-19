package first.member.service;

import java.util.Map;

public interface MemberService {

	int idCheck(Map<String, Object> map) throws Exception;

	int insertMember(Map<String, Object> map) throws Exception;

	boolean logIn(Map<String, Object> map) throws Exception;

}

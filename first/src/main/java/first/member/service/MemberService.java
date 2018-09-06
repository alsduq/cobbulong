package first.member.service;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import first.common.common.Result;
import first.member.dto.FindIdResult;

public interface MemberService {

	int idCheck(Map<String, Object> map) throws Exception;

	Result insertMember(Map<String, Object> map) throws Exception;

	Result logIn(Map<String, Object> map, HttpSession session, HttpServletRequest request) throws Exception;

	FindIdResult findId(Map<String, Object> map);

	Result sendAuthNo(Map<String, Object> map) throws AddressException, MessagingException ;

	Result authNoCheck(Map<String, Object> map) throws AddressException, MessagingException;

	Result changePassword(Map<String, Object> map);

	Result logOut(Map<String, Object> map, HttpSession session, HttpServletRequest request);
	
	Result logOutLog(String userId);

}

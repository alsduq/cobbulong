package first.member.service;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import first.member.dto.FindIdResult;
import first.member.dto.Result;

public interface MemberService {

	int idCheck(Map<String, Object> map) throws Exception;

	Result insertMember(Map<String, Object> map) throws Exception;

	boolean logIn(Map<String, Object> map) throws Exception;

	FindIdResult findId(Map<String, Object> map);

	Result sendAuthNo(Map<String, Object> map) throws AddressException, MessagingException ;

	Result authNoCheck(Map<String, Object> map) throws AddressException, MessagingException;

	Result changePassword(Map<String, Object> map);

}

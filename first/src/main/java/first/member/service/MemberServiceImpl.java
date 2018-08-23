package first.member.service;

import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.apache.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import first.common.util.CommonUtils;
import first.common.util.MailUtils;
import first.common.util.PasswordUtils;
import first.member.dao.MemberDAO;
import first.member.dto.FindIdResult;
import first.member.dto.Result;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Resource(name="mailUtils")
	private MailUtils mailUtils;
	
	@Resource(name="passwordUtils")
	private PasswordUtils passwordUtils;
	
	@Override
	public int idCheck(Map<String, Object> map) throws Exception {
		return memberDAO.selectId(map);
	}

	@Override
	public Result insertMember(Map<String, Object> map) throws Exception {
		Map<String, Object> tmp = map;
		tmp.put("inputPassword1", BCrypt.hashpw((String)tmp.get("inputPassword1"), BCrypt.gensalt()));
		int result = memberDAO.insertMember(tmp);
		
		if(result == -1) {
			return new Result(false, "회원가입 도 중 문제가 발생하였습니다.");
		} else if(result == -2) {
			return new Result(false, "이미 가입 되어있는 이메일 입니다.");
		} else {
			return new Result(true, "회원가입에 성공 하였습니다.");
		}
	}

	@Override
	public boolean logIn(Map<String, Object> map)  throws Exception {
		String passwordHashed = memberDAO.logIn(map);
		try {
			return BCrypt.checkpw((String) map.get("inputPassword"), passwordHashed);
		} catch (NullPointerException e){
			return false;
		}
	}

	@Override
	public FindIdResult findId(Map<String, Object> map) {
		String id = memberDAO.findId(map);
		if(id == null) {
			return new FindIdResult(false, "가입 정보가 없습니다.", null);
		}else {
			return new FindIdResult(true, "아이디 찾기에 성공하셨습니다.", id);
		}
	}

	@Override
	public Result sendAuthNo(Map<String, Object> map) throws AddressException, MessagingException {
		Map<String, Object> tmpMap = map;
		
		int result = memberDAO.confirmAccount(tmpMap);
		if(result != 0) {
			String recipient = (String) map.get("inputEmail2");
			String subject = "코뿌롱 이메일 인증";
			String authNum = CommonUtils.getRandomString().substring(0, 6);
			tmpMap.put("authNum", authNum);
			try {
				memberDAO.updateAuthNo(tmpMap);
				String body = "인증번호는 ["+ authNum +"] 입니다.";
				mailUtils.sendMail(recipient, subject, body);
			}catch(Exception e) {
				return new Result(false, "인증 과정 도 중 알수없는 에러가 발생하였습니다.");
			}
			return new Result(true, "이메일로 인증번호가 전송되었습니다.\n\r전송된 인증번호를 입력해 주세요.", recipient);
		}else {
			return new Result(false, "가입 정보가 없습니다.");
		}
	}

	@Override
	public Result authNoCheck(Map<String, Object> map) throws AddressException, MessagingException {
		Map<String, Object> tmpMap = map;
		int result = memberDAO.authNoCheck(map);
		if(result != 1) {
			return new Result(false, "인증번호가 일치하지 않습니다.");
		}else {
			String tmpPassword = passwordUtils.getTmpPassword();
			tmpMap.put("inputPassword", tmpPassword);
			passwordUtils.changePassword(tmpMap);
			
			String recipient = (String) map.get("inputEmail");
			String subject = "코뿌롱 임시 비밀번호";
			String body = "임시 비밀번호가 발급되었습니다.<br>["+ tmpPassword +"]<br>로그인 하신 후 비밀번호를 변경해 주세요.";
			mailUtils.sendMail(recipient, subject, body);
			return new Result(true, "임시 비밀번호가 전송되었습니다.");
		}
	}

}

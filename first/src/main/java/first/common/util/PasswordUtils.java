package first.common.util;
 
import java.util.Map;

import javax.annotation.Resource;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Component;

import first.member.dao.MemberDAO;
import first.member.dto.Result;
 
@Component("passwordUtils")
public class PasswordUtils {
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	public Result changePassword(Map<String, Object> map) {
    	try {
    		Map<String, Object> tmp = map;
    		tmp.put("inputPassword", BCrypt.hashpw((String)tmp.get("inputPassword"), BCrypt.gensalt()));
    		memberDAO.updatePassword(tmp);
    	}catch(Exception e) {
    		return new Result(false, "비밀번호 변경 도 중 알 수 없는 에러가 발생하였습니다.");
    	}
    	return new Result(true, "비밀번호가 변경 되었습니다.");
    }
	
	public String getTmpPassword() {
		return CommonUtils.getRandomString().substring(0, 10);
    }
	
}
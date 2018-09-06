package first.common.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import first.common.common.Result;
import first.member.dao.MemberDAO;

@Component("logoutUtils")
public class LogoutUtils {
	
	@Autowired
	private MemberDAO memberDAO;
	
	public Result logoutLog(String userId) {
		try {
//			MemberDAO memberDAO = new MemberDAO();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("inputId", userId);
			memberDAO.updateLogOutLog(map);
		} catch(Exception e) {
			e.printStackTrace();
			return new Result(false, "로그아웃 도 중 알 수 없는 에러가 발생하였습니다.");
		}
		return new Result(true, "로그아웃 성공");
	}
}

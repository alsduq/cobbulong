package first.member.service;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import first.member.dao.MemberDAO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="memberDAO")
	private MemberDAO memberDAO;
	
	@Override
	public int idCheck(Map<String, Object> map) throws Exception {
		return memberDAO.selectId(map);
	}

	@Override
	public int insertMember(Map<String, Object> map) throws Exception {
		Map<String, Object> tmp = map;
		tmp.put("inputPassword1", BCrypt.hashpw((String)tmp.get("inputPassword1"), BCrypt.gensalt()));
		return memberDAO.insertMember(tmp);
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

}

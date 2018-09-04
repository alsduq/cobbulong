package first.common.session;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import first.member.dao.MemberDAO;

@Component("user")
public class User implements HttpSessionBindingListener, Serializable{
	
	@Resource(name="memberDAO")
	private MemberDAO memberDao;
	
	Logger logger = Logger.getLogger(this.getClass());
	
	private static final long serialVersionUID = 0L;
    private HttpSession session;
    private String sessionId;
     
    private final String id;
    
    public User() {
    	this.id = null;
    }
    public User(String id){
        this.id = id;
    }
 
    //이 User객체게 session에 setAttribute 되는 시점에 실행됩니다.
    public void valueBound(HttpSessionBindingEvent event) {
        User user = (User)event.getValue();
        HttpSession session = event.getSession();
        user.sessionId = session.getId();
        user.session = session;
        //사용자 정보(사용자 id를 키값으로)를 맵에 담다둔다.
        Users.setUser(user.id, user);
    }
 
    // session 이 invalidated되거나 이 User객체가 session에서 removeAttribute된경우 실행됩니다.
    public void valueUnbound(HttpSessionBindingEvent event) {
//    	MemberDAO memberDao = new MemberDAO();
//        User user = (User)event.getValue();
//    	MemberServiceImpl memberServiceImpl = new MemberServiceImpl();
//    	memberServiceImpl.updateLogoutLog(id);
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("inputId", id);
    	memberDao.updateLogOutLog(map);
        Users.removeUser(id);
    }
 
    public HttpSession getSession() {
        return this.session;
    }
 
    public String getSessionId() {
        return this.sessionId;
    }
 
    public String getId() {
        return this.id;
    }

}

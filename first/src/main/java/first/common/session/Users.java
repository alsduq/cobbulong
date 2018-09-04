package first.common.session;

import java.util.HashMap;
import java.util.Map;

public class Users {
	 
    private final static Map<String, User> uniqueUsers = new HashMap<String, User>();
     
    public static int getSize(){
        return uniqueUsers.size();
    }
 
    public static User getUser(String id){
        return uniqueUsers.get(id);
    }
     
    static void removeUser(String id){
        uniqueUsers.remove(id);
    }
     
    static void setUser(String id, User user){
        uniqueUsers.put(id, user);
    }
}

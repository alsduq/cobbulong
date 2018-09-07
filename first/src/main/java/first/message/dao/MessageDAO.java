package first.message.dao;

import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import first.common.dao.AbstractDAO;
import first.message.dto.Message;

@Component("messageDAO")
public class MessageDAO extends AbstractDAO{
	Logger log = Logger.getLogger(this.getClass());

	public int sendMessage(Map<String, Object> map) {
		return (int) selectOne("message.insertMessage", map);
	}

	@SuppressWarnings("unchecked")
	public List<List<Object>> selectRecvMessage(Map<String, Object> map) {
		return (List<List<Object>>) selectList("message.selectRecvMessage", map);
	}

	public Message selectMessage(Map<String, Object> map) {
		return (Message) selectOne("message.selectMessage", map);
	}
	

}

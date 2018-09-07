package first.message.service;

import java.util.List;
import java.util.Map;

import first.common.common.Result;
import first.message.dto.Message;

public interface MessageService {

	Result sendMessage(Map<String, Object> map);

	List<List<Object>> recvMessage(Map<String, Object> map);

	Message openMessageDetail(Map<String, Object> map);

}

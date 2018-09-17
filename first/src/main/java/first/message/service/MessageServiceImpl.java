package first.message.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import first.common.common.Result;
import first.common.util.PasswordUtils;
import first.message.dao.MessageDAO;
import first.message.dto.Message;

@Service("messageService")
public class MessageServiceImpl implements MessageService{
	Logger logger = Logger.getLogger(this.getClass());
	
	@Resource(name="messageDAO")
	private MessageDAO messageDAO;
	
	@Resource(name="passwordUtils")
	private PasswordUtils passwordUtils;
	
	@Override
	public Result sendMessage(Map<String, Object> map) {
		try {
			int result = messageDAO.sendMessage(map);
			if(result == 1) {
				return new Result(false, "전송 완료.");
			}
			return new Result(false, "전송 실패.");
		}catch(Exception e) {
			return new Result(false, "전송 실패.");
		}
	}

	@Override
	public List<List<Object>> recvMessage(Map<String, Object> map) {
		return messageDAO.selectRecvMessage(map);
	}
	
	@Override
	public Message openMessageDetail(Map<String, Object> map) {
		return messageDAO.selectMessage(map);
	}

	@Override
	public List<List<Object>> sentMessage(Map<String, Object> map) {
		return messageDAO.selectSentMessage(map);
	}

	@Transactional(rollbackFor=Exception.class)
	@Override
	public Result deleteMessage(Map<String, Object> map, String[] messageIdx) {
		int result;
		for(String idx : messageIdx) {
			map.put("idx", idx);
			result = messageDAO.deleteMessage(map);
			if(result != 1) {
				try {
					throw new Exception("삭제 실패.");
				}catch(Exception e) {
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					return new Result(false, "삭제 실패");
				}
			}
		}
		return new Result(true, "메세지가 삭제되었습니다.");
	}



	

}

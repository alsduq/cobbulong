package first.message.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;
import first.common.common.Result;
import first.message.dto.Message;
import first.message.service.MessageService;

@Controller
public class MessageController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="messageService")
	private MessageService messageService;
	
	@RequestMapping(value="/message/openMessageWrite.do")
    public ModelAndView openBoardList(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/message/messageWrite");
    	mv.addObject("to", commandMap.get("to"));
    	return mv;
    }
	
	@RequestMapping(value="/message/sendMessage.do")
    public @ResponseBody Result sendMessage(CommandMap commandMap) throws Exception{
		return messageService.sendMessage(commandMap.getMap());
	}	
	
	@RequestMapping(value="/message/openRecvMessage.do")
    public ModelAndView openRecvMessage(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/message/recvMessage");
		List<List<Object>> messageList = messageService.recvMessage(commandMap.getMap());
    	mv.addObject("messageList", messageList.get(0));
    	mv.addObject("count", messageList.get(1).get(0));
    	mv.addObject("pageIdx", messageList.get(2).get(0));
    	return mv;
    }
	
	@RequestMapping(value="/message/openMessageDetail.do")
    public ModelAndView openMessageDetail(CommandMap commandMap) throws Exception{
		ModelAndView mv = null;
		if(commandMap.getMap().get("type").equals("R")) {
			mv = new ModelAndView("/message/recvMessageDetail");
		}else {
			mv = new ModelAndView("/message/sentMessageDetail");
		}
		Message message = messageService.openMessageDetail(commandMap.getMap());
    	mv.addObject("message", message);
    	mv.addObject("pageIdx", commandMap.getMap().get("page_idx"));
    	return mv;
    }
	
	@RequestMapping(value="/message/openSentMessage.do")
    public ModelAndView openSentMessage(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/message/sentMessage");
		List<List<Object>> messageList = messageService.sentMessage(commandMap.getMap());
    	mv.addObject("messageList", messageList.get(0));
    	mv.addObject("count", messageList.get(1).get(0));
    	mv.addObject("pageIdx", messageList.get(2).get(0));
    	return mv;
    }
	
	@RequestMapping(value="/message/deleteMessage.do")
    public @ResponseBody Result deleteMessage(CommandMap commandMap, String[] messageIdx) throws Exception{
		return messageService.deleteMessage(commandMap.getMap(), messageIdx);
	}
	
}

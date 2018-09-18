package first.chatting.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;

@Controller
public class ChattingController {
	Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value="/chatting/openChatting.do")
    public ModelAndView openChatting(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/chatting/chatting");
    	return mv;
    }
	
}

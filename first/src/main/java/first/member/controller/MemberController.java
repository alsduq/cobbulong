package first.member.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;
import first.member.service.MemberService;

@Controller
public class MemberController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@RequestMapping(value="/member/openSignUp.do")
    public ModelAndView openBoardList(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/member/signUp");
    	return mv;
    }
	
	@RequestMapping(value="/member/idCheck.do")
    public @ResponseBody int idCheck(CommandMap commandMap) throws Exception{
		return memberService.idCheck(commandMap.getMap());
	}	

	@RequestMapping(value="/member/signUp.do")
    public @ResponseBody int signUp(CommandMap commandMap) throws Exception{
		int result = memberService.insertMember(commandMap.getMap());
		return result;
	}	
	
	@RequestMapping(value="/member/openLogIn.do")
    public ModelAndView openLogIn(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/member/logIn");
    	return mv;
    }
	
	@RequestMapping(value="/member/logIn.do")
    public @ResponseBody boolean logIn(CommandMap commandMap) throws Exception{
		boolean result = memberService.logIn(commandMap.getMap());
		return result;
	}	
}

package first.member.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;
import first.common.common.Result;
import first.member.dto.FindIdResult;
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
    public @ResponseBody Result signUp(CommandMap commandMap) throws Exception{
		return memberService.insertMember(commandMap.getMap());
	}	
	
	@RequestMapping(value="/member/openLogIn.do")
    public ModelAndView openLogIn(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/member/logIn");
    	return mv;
    }
	
	@RequestMapping(value="/member/logIn.do")
    public @ResponseBody Result logIn(CommandMap commandMap, HttpSession session, HttpServletRequest request) throws Exception{
		return memberService.logIn(commandMap.getMap(), session, request);
	}	
	
	@RequestMapping(value="/member/logOut.do")
    public @ResponseBody Result logOut(CommandMap commandMap, HttpSession session, HttpServletRequest request){
		return memberService.logOut(commandMap.getMap(), session, request);
	}
	
	@RequestMapping(value="/member/openFindIdPw.do")
    public ModelAndView openFindIdPw(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/member/findIdPw");
    	return mv;
    }
	
	@RequestMapping(value="/member/findId.do")
    public @ResponseBody FindIdResult findId(CommandMap commandMap) throws Exception{
		return memberService.findId(commandMap.getMap());
	}	
		
	@RequestMapping(value="/member/openFindIdResult.do")
    public ModelAndView openFindIdResult() throws Exception{
		ModelAndView mv = new ModelAndView("/member/findIdResult");
    	return mv;
	}	
	
	@RequestMapping(value="/member/sendAuthNo.do")
    public @ResponseBody Result sendAuthNo(CommandMap commandMap) throws Exception{
		return memberService.sendAuthNo(commandMap.getMap());
	}
	
	@RequestMapping(value="/member/emailAuth.do")
    public ModelAndView emailAuth() throws Exception{
		ModelAndView mv = new ModelAndView("/member/emailAuth");
    	return mv;
	}	
	
		
	@RequestMapping(value="/member/authNoCheck.do")
    public @ResponseBody Result authNoCheck(CommandMap commandMap) throws Exception{
		return memberService.authNoCheck(commandMap.getMap());
	}
		
	@RequestMapping(value="/member/openChangePassword.do")
    public ModelAndView openChangePassword() throws Exception{
		ModelAndView mv = new ModelAndView("/member/changePassword");
    	return mv;
	}
	
	@RequestMapping(value="/member/changePassword.do")
    public @ResponseBody Result changePassword(CommandMap commandMap) throws Exception{
		return memberService.changePassword(commandMap.getMap());
	}
}

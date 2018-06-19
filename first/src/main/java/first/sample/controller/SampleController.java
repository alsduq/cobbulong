package first.sample.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;
import first.sample.service.SampleService;

@Controller
public class SampleController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="sampleService")
	private SampleService sampleService;
	
	@RequestMapping(value="/sample/openBoardList.do")
    public ModelAndView openBoardList(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("/sample/boardList");
    	List<List<Object>> list = sampleService.selectBoardList(commandMap.getMap());
    	mv.addObject("list", list.get(0));
    	mv.addObject("count", list.get(1).get(0));
    	mv.addObject("pageIdx", list.get(2).get(0));
    	return mv;
    }
	
	@RequestMapping(value="/sample/openBoardWrite.do")
	public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/sample/boardWrite");
		return mv;
	}
	
	@RequestMapping(value="/sample/insertBoard.do")
	public ModelAndView insertBoard(CommandMap commandMap, HttpServletRequest request) throws Exception{
	    ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
	    sampleService.insertBoard(commandMap.getMap(), request);
	    return mv;
	}
	
	@RequestMapping(value="/sample/openBoardDetail.do")
	public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/sample/boardDetail");
		List<Object>/*Map<String,Object>*/ map = sampleService.selectBoardDetail(commandMap.getMap());
		mv.addObject("map", map.get(0));
		mv.addObject("list", map.get(1));
		return mv;
	}
	
	@RequestMapping(value="/sample/openBoardUpdate.do")
	public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("/sample/boardUpdate");
		List<Object> resultList = sampleService.selectBoardDetail(commandMap.getMap());
		@SuppressWarnings("unchecked")
		Map<String, Object> map = (Map<String, Object>) resultList.get(0);
		String tmpContents = (String) map.get("contents");
		tmpContents = tmpContents.replace("<br>", "\r\n");
		map.put("contents", tmpContents);
		
		mv.addObject("map", map);
		return mv;
	}
	
	@RequestMapping(value="/sample/updateBoard.do")
	public ModelAndView updateBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/sample/openBoardDetail.do");
		
		sampleService.updateBoard(commandMap.getMap());
		
		mv.addObject("idx", commandMap.get("idx"));
		return mv;
	}
	
	@RequestMapping(value="/sample/deleteBoard.do")
	public ModelAndView deleteBoard(CommandMap commandMap) throws Exception{
		ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
		
		sampleService.deleteBoard(commandMap.getMap());
		
		return mv;
	}
	
	@RequestMapping(value="/sample/commentInsert.do")
	public @ResponseBody void commentInsert(CommandMap commandMap) throws Exception{
		sampleService.insertComment(commandMap.getMap());
	}
	
	@RequestMapping(value="/sample/commentUpdate.do")
	public @ResponseBody void commentUpdate(CommandMap commandMap) throws Exception{
		sampleService.updateComment(commandMap.getMap());
	}
	
	@RequestMapping(value="/sample/commentList.do")
    public @ResponseBody List<Map<String,Object>> commentList(CommandMap commandMap) throws Exception{
		List<Map<String, Object>> list = sampleService.selectCommentList(commandMap.getMap());
    	return list;
    }
	
	@RequestMapping(value="/sample/commentDelete.do")
    public @ResponseBody void commentDelete(CommandMap commandMap) throws Exception{
		sampleService.deleteComment(commandMap.getMap());
    }
	
	
}

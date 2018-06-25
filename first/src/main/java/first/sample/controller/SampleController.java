package first.sample.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import first.common.common.CommandMap;
import first.sample.service.SampleService;
import first.sample.vo.PhotoVo;

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
	
	
	//단일파일업로드
	@RequestMapping(value="/sample/photoUpload.do")
	public String photoUpload(HttpServletRequest request, PhotoVo vo) throws Exception {
	    String callback = vo.getCallback();
	    String callback_func = vo.getCallback_func();
	    String file_result = "";
	    try {
	        if(vo.getFiledata() != null && vo.getFiledata().getOriginalFilename() != null && !vo.getFiledata().getOriginalFilename().equals("")){
	            //파일이 존재하면
	            String original_name = vo.getFiledata().getOriginalFilename();
	            String ext = original_name.substring(original_name.lastIndexOf(".")+1);
	            //파일 기본경로
	            String defaultPath = request.getSession().getServletContext().getRealPath("/");
	            //파일 기본경로 _ 상세경로
	            String path = defaultPath + "resource" + File.separator + "photo_upload" + File.separator;             
	            File file = new File(path);
	            System.out.println("path:"+path);
	            //디렉토리 존재하지 않을경우 디렉토리 생성
	            if(!file.exists()) {
	                file.mkdirs();
	            }
	            //서버에 업로드 할 파일명(한글문제로 인해 원본파일은 올리지 않는것이 좋음)
	            String realname = UUID.randomUUID().toString() + "." + ext;
	        ///////////////// 서버에 파일쓰기 /////////////////
	            vo.getFiledata().transferTo(new File(path+realname));
	            file_result += "&bNewLine=true&sFileName="+original_name+"&sFileURL=/resource/photo_upload/"+realname;
	        } else {
	            file_result += "&errstr=error";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return "redirect:" + callback + "?callback_func="+callback_func+file_result;
	}

	//다중파일업로드
	@RequestMapping(value="/sample/fileUploaderHtml5.do")
	public void multiplePhotoUpload(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    try {
	         //파일정보
	         String sFileInfo = "";
	         //파일명을 받는다 - 일반 원본파일명
	         String filename = request.getHeader("file-name");
	         //파일 확장자
	         String filename_ext = filename.substring(filename.lastIndexOf(".")+1);
	         //확장자를소문자로 변경
	         filename_ext = filename_ext.toLowerCase();
	         //파일 기본경로
	         //String dftFilePath = request.getSession().getServletContext().getRealPath("/");
	         //파일 기본경로 _ 상세경로
	         String filePath = File.separator + "var" + File.separator + "webapps" + File.separator + "upload" + File.separator + "image" + File.separator;
	         File file = new File(filePath);
	         if(!file.exists()) {
	            file.mkdirs();
	         }
	         String realFileNm = "";
	         SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	         String today= formatter.format(new java.util.Date());
	         realFileNm = today+UUID.randomUUID().toString() + filename.substring(filename.lastIndexOf("."));
	         String rlFileNm = filePath + realFileNm;
	         ///////////////// 서버에 파일쓰기 /////////////////
	         InputStream is = request.getInputStream();
	         OutputStream os=new FileOutputStream(rlFileNm);
	         int numRead;
	         byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
	         while((numRead = is.read(b,0,b.length)) != -1){
	            os.write(b,0,numRead);
	         }
	         if(is != null) {
	            is.close();
	         }
	         os.flush();
	         os.close();
	         ///////////////// 서버에 파일쓰기 /////////////////
	         // 정보 출력
	         sFileInfo += "&bNewLine=true";
	         // img 태그의 title 속성을 원본파일명으로 적용시켜주기 위함
	         sFileInfo += "&sFileName="+ filename;
	         sFileInfo += "&sFileURL="+"/upload/image/"+realFileNm;
	         PrintWriter print = response.getWriter();
	         print.print(sFileInfo);
	         print.flush();
	         print.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
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
		List<Object> map = sampleService.selectBoardDetail(commandMap.getMap());
//		@SuppressWarnings("unchecked")
//		Map<String, Object> map = (Map<String, Object>) resultList.get(0);
//		String tmpContents = (String) map.get("contents");
//		tmpContents = tmpContents.replace("<br>", "\r\n");
//		map.put("contents", tmpContents);
		
		mv.addObject("map", map.get(0));
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

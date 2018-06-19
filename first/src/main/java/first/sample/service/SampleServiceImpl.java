package first.sample.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import first.common.util.FileUtils;
import first.sample.dao.SampleDAO;

@Service("sampleService")
public class SampleServiceImpl implements SampleService{
    Logger log = Logger.getLogger(this.getClass());
     
    @Resource(name="fileUtils")
    private FileUtils fileUtils;
     
    @Resource(name="sampleDAO")
    private SampleDAO sampleDAO;
     
    @SuppressWarnings("unchecked")
	@Override
    public List<List<Object>> selectBoardList(Map<String, Object> map) throws Exception {
//    	List<List<Object>> resultList = sampleDAO.selectBoardList(map);
//    	List<Object> tmpList = resultList.get(0);
//    	Map<String,Object> tmpMap = new HashMap<String,Object>();
//    	
//    	
//    	SimpleDateFormat df1 = new SimpleDateFormat("YYYY-MM-DD");
//    	SimpleDateFormat df2 = new SimpleDateFormat("HH:mm:ss");
//    	Date today = new Date();
//    	Date crea_dtm = new Date();
//    	
//    	for(int i = 0; i < tmpList.size(); i++) {
//    		tmpMap = (Map<String, Object>) tmpList.get(i);
//    		crea_dtm = (Date) tmpMap.get("crea_dtm");
//    		log.debug(crea_dtm);
//    		if((today.getTime() - crea_dtm.getTime()) > 1000*60*60*24) {
//    			crea_dtm = df1.format(crea_dtm);
//    		}
//    	
//    	}
    	
        return sampleDAO.selectBoardList(map);
         
    }
 
    @Override
    public void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception {
    	Map<String, Object> tmpMap = map;
    	sampleDAO.insertBoard(tmpMap);
        List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(map, request);
        for(int i=0, size=list.size(); i<size; i++){
            sampleDAO.insertFile(list.get(i));
        }
    }
 
    @Override
    public List<Object>/*Map<String, Object>*/ selectBoardDetail(Map<String, Object> map) throws Exception {
        sampleDAO.updateHitCnt(map);
//        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<Object> result = new ArrayList<Object>();
        Map<String, Object> tmpMap = sampleDAO.selectBoardDetail(map);
        String tmpContents = String.valueOf(tmpMap.get("contents"));
        tmpContents = tmpContents.replace("\r\n", "<br>");
        tmpContents = tmpContents.replace("\u0020", "&nbsp;");
        
        tmpMap.put("contents", tmpContents);
//        resultMap.put("map", tmpMap);
        result.add(tmpMap);
        List<Map<String,Object>> list = sampleDAO.selectFileList(map);
//        resultMap.put("list", list);
        result.add(list);
        return result;
    }
 
    @Override
    public void updateBoard(Map<String, Object> map) throws Exception{
    	Map<String, Object> tmp = map;
        sampleDAO.updateBoard(tmp);
    }
 
    @Override
    public void deleteBoard(Map<String, Object> map) throws Exception {
        sampleDAO.deleteBoard(map);
    }

	@Override
	public void insertComment(Map<String, Object> map) throws Exception {
		sampleDAO.insertComment(map);
	}

	@Override
	public void updateComment(Map<String, Object> map) throws Exception {
		sampleDAO.updateComment(map);
	}
	
	@Override
	public List<Map<String, Object>> selectCommentList(Map<String, Object> map) throws Exception {
        List<Map<String, Object>> list= sampleDAO.selectCommentList(map);
        List<Map<String, Object>> tmpList = new ArrayList<Map<String, Object>>();
        Map<String, Object> tmpMap;
        String tmpContents;
        for(int i = 0; i < list.size(); i++) {
        	tmpMap = list.get(i);
        	tmpContents = String.valueOf(tmpMap.get("contents"));
        	tmpContents = tmpContents.replace("\r\n", "<br>");
        	tmpContents = tmpContents.replace("\u0020", "&nbsp;");
        	tmpMap.put("contents",  tmpContents);
        	tmpList.add(tmpMap);
        }
        list = tmpList;
		return list;
	}

	@Override
	public void deleteComment(Map<String, Object> map) throws Exception {
		sampleDAO.deleteComment(map);
	}

}
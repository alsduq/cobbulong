package first.sample.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SampleService {

	List<List<Object>> selectBoardList(Map<String, Object> map) throws Exception;

	void insertBoard(Map<String, Object> map, HttpServletRequest request) throws Exception;

	List<Object>/*Map<String, Object>*/ selectBoardDetail(Map<String, Object> map) throws Exception;

	void updateBoard(Map<String, Object> map) throws Exception;

	void deleteBoard(Map<String, Object> map) throws Exception;

	void insertComment(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectCommentList(Map<String, Object> map) throws Exception;

	void deleteComment(Map<String, Object> map) throws Exception;

	void updateComment(Map<String, Object> map) throws Exception;

}

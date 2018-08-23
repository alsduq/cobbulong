package first.member.dto;

public class FindIdResult {
	private boolean isSuccess;
	private String msg;
	private String id;
	
	public FindIdResult () {
		this.isSuccess = true;
		this.msg = "정상입니다.";
		this.id = null;
	}
	
	public FindIdResult (boolean isSuccess, String msg) {
		this.isSuccess = isSuccess;
		this.msg = msg;
	}
	
	public FindIdResult (boolean isSuccess, String msg, String id) {
		this.isSuccess = isSuccess;
		this.msg = msg;
		this.id = id;
	}
	
	public boolean getIsSuccess() {
		return isSuccess;
	}
	public void setIsSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}

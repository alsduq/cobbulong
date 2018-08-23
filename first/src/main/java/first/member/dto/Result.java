package first.member.dto;

public class Result {
	private boolean isSuccess;
	private String msg;
	private String data;
	
	public Result () {
		this.isSuccess = true;
		this.msg = "정상입니다.";
	}
	
	public Result (boolean isSuccess, String msg) {
		this.isSuccess = isSuccess;
		this.msg = msg;
	}
	
	public Result (boolean isSuccess, String msg, String data) {
		this.isSuccess = isSuccess;
		this.msg = msg;
		this.data = data;
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

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}
}

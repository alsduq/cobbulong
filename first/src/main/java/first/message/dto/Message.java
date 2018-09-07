package first.message.dto;

public class Message {
	private int idx;
	private String title;
	private String sender;
	private Object crea_dtm;
	private String contents;
	
	public Message() {
	}
			
	public Message(int idx, String title, String sender, Object crea_dtm, String contents) {
		this.idx = idx;
		this.title = title;
		this.sender = sender;
		this.crea_dtm = crea_dtm;
		this.contents = contents;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public Object getCrea_dtm() {
		return crea_dtm;
	}
	public void setCrea_dtm(Object crea_dtm) {
		this.crea_dtm = crea_dtm;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}
}

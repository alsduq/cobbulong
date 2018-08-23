package first.common.util;
 
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;
 
@Component("mailUtils")
public class MailUtils {
    public void sendMail(String recipient, String subject, String body) throws AddressException, MessagingException{
    	String host = "smtp.naver.com";
		 final String serverId = "alsduq2813";
		 final String serverPw = "dPwlsdktkfkdgo";
		 int port = 465;
		 
		 Properties props = System.getProperties();
		 
		 props.put("mail.smtp.host", host); 
		 props.put("mail.smtp.port", port); 
		 props.put("mail.smtp.auth", "true"); 
		 props.put("mail.smtp.ssl.enable", "true"); 
		 props.put("mail.smtp.ssl.trust", host);
		 
		 Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			 String un = serverId; 
			 String pw = serverPw; 
			 protected javax.mail.PasswordAuthentication getPasswordAuthentication() { 
				 return new javax.mail.PasswordAuthentication(un, pw); 
			 } 
		 });
		 
		 session.setDebug(true); //for debug
		 
		 Message mimeMessage = new MimeMessage(session);
		 mimeMessage.setFrom(new InternetAddress("alsduq2813@naver.com"));
		 mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
		 
		 mimeMessage.setSubject(subject);
		 mimeMessage.setText(body);
		 Transport.send(mimeMessage);
    }
}
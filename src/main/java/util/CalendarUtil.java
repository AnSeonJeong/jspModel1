package util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;

import dao.CalendarDao;
import dto.CalendarDto;

public class CalendarUtil {
	// 문자열검사 : 빈문자 -> true
	public static boolean nvl(String msg) {
		return msg == null || msg.trim().equals("")?true:false;
	}
	// ifnull("컬럼명", value)
	
	// 한자리 숫자를 두자리로 만들어 주는 함수 : 1 ~ 9 -> 01 ~ 09
	public static String two(String msg) {
		return msg.trim().length()<2 ? "0"+msg.trim() : msg.trim();
	}
	
	// 일(날짜)별 일정을 모두 볼 수 있는 calendar.jsp로 이동
	public static String callist(int year, int month, int day) {
		String str = "";
		
		str += String.format("&nbsp;<a href='callist.jsp?year=%d&month=%d&day=%d'>", year, month, day);
		str += String.format("%2d", day);
		str += "</a>";
		
		return str;
	}
	
	// 일정추가
	public static String calwrite(int year, int month, int day) {
		String str = "";
		
		String image = "<img src='images/pen2.png' width='18px' heigth='18px'>";
		
		str = String.format("<a href='calwrite.jsp?year=%d&month=%d&day=%d'>%s</a>",
								year, month, day, image);
		return str;
	}
	
	// 문장이 길 경우 단락으로 처리하는 함수
	// cgv에서 여사친과 영하보고 데이트 -> cgv에서...
	private static String dot3(String msg) {
		String str = "";
		if(msg.length() >= 6) {
			str = msg.substring(0, 6); // 0~10전까지
			str += "...";
		} else {
			str = msg.trim();
		}
		return str;
	}
	
	// 날짜별로 테이블을 생성하기 위한 함수
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str= "";
		
		// 2023 2 16 -> 20230216
		String dates = (year + "") + two(month + "") + two(day + "");
		
		str += "<table>";
		
		// rdate = 20230216110435 -> 20230216 
		for(CalendarDto dto : list) {
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr>";
				str += " <td style='padding:0px;height:20px'>";
				str += "	<a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";
				str += "		<font style='font-size:10px'>";
				str += 				dot3(dto.getTitle());
				str += "		</font>";
				str += "	</a>";
				str += " </td>";
				str += "</tr>";
			}
		}
		
		str += "</table>";
		
		return str;
	}
	
	// 날짜를 출력이 보기 좋게 하는 함수
	public static String toDates(String mdate) {
		// 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 hh시 mm분");
		
		// 202302170942
		String s = mdate.substring(0, 4) + "-" 		// yyyy
					+ toOne(mdate.substring(4, 6)) + "-"	// MM
					+ toOne(mdate.substring(6, 8)) + " "	// dd
					+ toOne(mdate.substring(8, 10)) + ":"	// hh
					+ toOne(mdate.substring(10)) + ":00"; 	// mm
		
		Timestamp d = Timestamp.valueOf(s);
		return sdf.format(d);
	}
	
	// 앞에 0이 있는 문자열을 한자리로 변환	  08 -> 8
	public static String toOne(String msg) {
		return msg.charAt(0) == '0'?msg.charAt(1)+"":msg;
		
	}
}

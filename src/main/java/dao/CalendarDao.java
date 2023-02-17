package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.DBClose;
import db.DBConnection;
import dto.CalendarDto;

public class CalendarDao {
	private static CalendarDao dao = null;
	
	private CalendarDao() {
		DBConnection.initConnection();
	}
	
	public static CalendarDao getInstance() {
		if(dao == null) {
			dao = new CalendarDao();
		}
		return dao;
	}
	
	public List<CalendarDto> getCalendarList(String id, String yyyyMM) {
		String sql = " select seq, id, title, content, rdate, wdate "
				+ "from "
				+ "	(select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum, "
				+ "		seq, id, title, content, rdate, wdate "
				+ "	from calendar "
				+ "	where id=? and substr(rdate, 1, 6)=?) a "
				+ "where rnum between 1 and 5; ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn= DBConnection.getConnection();
			System.out.println("1/3 getCalendarList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyyMM);
			System.out.println("2/3 getCalendarList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getCalendarList success");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(rs.getInt(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++));
				list.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("getCalendarList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	
	public CalendarDto getDay(int seq) {
		String sql = " select seq, id, title, content, rdate, wdate "
				+ "	   from calendar "
				+ "	   where seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		CalendarDto dto = null;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getDay success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, seq);
			System.out.println("2/3 getDay success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getDay success");
			
			if(rs.next()) {
				dto = new CalendarDto(rs.getInt(1), 
									  rs.getString(2), 
									  rs.getString(3), 
									  rs.getString(4), 
									  rs.getString(5), 
									  rs.getString(6));
			}
			
		} catch (SQLException e) {
			System.out.println("getDay fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return dto;
	}
	
	public List<CalendarDto> getDayList(String id, String yyyymmdd) {
		String sql = " select seq, id, title, content, rdate, wdate "
				+ "	   from calendar "
				+ "	   where id=? and substr(rdate, 1, 8)=? "
				+ "	   order by rdate asc ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getDayList success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setString(2, yyyymmdd);
			System.out.println("2/3 getDayList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getDayList success");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(rs.getInt(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++), 
						                          rs.getString(i++));
				list.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("getDayList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	
	public List<CalendarDto> getCalSearchList(String choice, String search) {
		String sql = " select seq, id, title, content, rdate, wdate "
				+ "	   from calendar ";
		
		String searchSql = "";
		if(choice.equals("title")) {
			searchSql = " where title like '%"+ search +"%'; ";
		}
		else if(choice.equals("content")) {
			searchSql = " where content like '%"+ search +"%'; ";
		}
		else if(choice.equals("")) {
			searchSql = " where content =" + search;
		}
		sql += searchSql;
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		List<CalendarDto> list = new ArrayList<CalendarDto>();
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 getCalSearchList success");
			
			psmt = conn.prepareStatement(sql);
			System.out.println("2/3 getCalSearchList success");
			
			rs = psmt.executeQuery();
			System.out.println("3/3 getCalSearchList success");
			
			while(rs.next()) {
				int i = 1;
				CalendarDto dto = new CalendarDto(rs.getInt(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++), 
												  rs.getString(i++));
				list.add(dto);  
			}
			
		} catch (SQLException e) {
			System.out.println("getCalSearchList fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, rs);
		}
		return list;
	}
	
	public boolean addCalendar(CalendarDto dto) {
		String sql = " insert into calendar(id, title, content, rdate, wdate) "
				+ "	   values(?, ?, ?, ?, now()) ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 addCalendar success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getRdate());
			System.out.println("2/3 addCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 addCalendar success");
			
		} catch (SQLException e) {
			System.out.println("addCalendar fail");
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0;
	}
	
	public boolean updateCalendar(int seq, String title, String rdate, String content) {
		String sql = " update calendar "
				+ "	   set title=?, rdate=?, content=?, wdate=now() "
				+ "    where seq=?";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 updateCalendar success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, title);
			psmt.setString(2, rdate);
			psmt.setString(3, content);
			psmt.setInt(4, seq);
			System.out.println("2/3 updateCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 updateCalendar success");
			System.out.println("count =" + count);
			
		} catch (SQLException e) {
			System.out.println("updateCalendar fail");			
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0;
	}
	
	public boolean deleteCalendar(String id, int seq) {
		String sql = " delete from calendar "
				+ "    where id=? and seq=? ";
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		int count = 0;
		
		try {
			conn = DBConnection.getConnection();
			System.out.println("1/3 deleteCalendar success");
			
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, id);
			psmt.setInt(2, seq);
			System.out.println("2/3 deleteCalendar success");
			
			count = psmt.executeUpdate();
			System.out.println("3/3 deleteCalendar success");
			
		} catch (SQLException e) {
			System.out.println("deleteCalendar fail");			
			e.printStackTrace();
		} finally {
			DBClose.close(conn, psmt, null);
		}
		return count>0;
	}
}

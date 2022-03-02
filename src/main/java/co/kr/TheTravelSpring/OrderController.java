package co.kr.TheTravelSpring;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.apache.ibatis.session.SqlSession;//MyBatis

import model.notice.NoticeDto;
import model.order.OrderDto;
import model.product.ProductDto;
import model.qna.QnaDto;

import org.springframework.ui.Model;

import util.PageTest;

@RequestMapping("/order")
@Controller
public class OrderController {
	
	@Autowired
	private SqlSession sqlSession;
	
	//리스트
	@RequestMapping(value = "/list.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String listOrder(Model model, HttpServletRequest request, String start_date, String end_date, String pageNum) {
		
		//1. 파라미터 받기
		SimpleDateFormat dateformat = new SimpleDateFormat ("yyyy-MM-dd");
		
		if (pageNum == null) {
			pageNum = "1";
		}
		
		//2. 처리 - 주문자 세션값으로 처리
		HttpSession session = request.getSession();
		String mem_id = (String)session.getAttribute("userId");		
	
		//2. 처리 - 디폴트 검색 기간  셋팅
		Date time = new Date();
		Calendar cal = Calendar.getInstance();
		
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int startday = cal.getMinimum(Calendar.DAY_OF_MONTH);
		int endday = cal.getMaximum(Calendar.DAY_OF_MONTH);			
		
		if(start_date == null) {
			cal.set(year,  month-1, startday);			
			start_date = dateformat.format(cal.getTime());
		}
		
		if(end_date == null) {
			cal.set(year,  month-1, endday);			
			end_date = dateformat.format(cal.getTime());
		}
		
		//2. 처리 - 주문 갯수 얻기
		Map<String, Object> map = new HashMap<String, Object>();	
		map.put("mem_id", mem_id);
		map.put("start_date", start_date);
		map.put("end_date", end_date);
				
		int cnt = sqlSession.selectOne("order.selectCount", map);		
		
		//2. 처리 - 목록 데이터 조회
		PageTest pageObj = new PageTest(cnt, Integer.parseInt(pageNum)); //페이지 처리
		
		map.put("start", new Integer(pageObj.getStartRow()-1));
		map.put("count", new Integer(pageObj.getPageSize())); ///10개씩
		
		List<OrderDto> list = sqlSession.selectList("order.selectListOrder", map);	
		
		if(pageObj.getEndPage()> pageObj.getPageCnt() ) {
			pageObj.setEndPage(pageObj.getPageCnt());
		}
		
		//3. 화면으로 값 리턴
		model.addAttribute("start_date", start_date);
		model.addAttribute("end_date", end_date);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("mem_id", mem_id);
		model.addAttribute("cnt", cnt);
		model.addAttribute("list", list);
		model.addAttribute("pdto", pageObj);
		
				
		return ".main.order.list";		
	}	
	
	//주문 폼
	@RequestMapping("/writeForm.do")
	public String writeForm(Model model,String pro_no) {
		
		//1. 파라미터 받기
		int proVal = Integer.parseInt(pro_no);
				
		//2. 내용 가져오기
		ProductDto dto = sqlSession.selectOne("order.selectOneProduct", proVal);
		
		//3. 화면으로 값 리턴
		model.addAttribute("pro_no",pro_no);
		model.addAttribute("dto", dto);
		
		return ".main.order.writeForm";		
	}	
	
	//주문 추가
	@RequestMapping(value="writePro.do",method=RequestMethod.POST)
	public String writePro(Model model, HttpServletRequest request, String pro_id, String ord_qty) {	
		
		OrderDto orderDto = new OrderDto();
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userId");
				
		orderDto.setPro_id(pro_id);
		orderDto.setMem_id(id);
		orderDto.setOrd_qty(Integer.parseInt(ord_qty));
		orderDto.setIp(request.getRemoteAddr());
		
		sqlSession.insert("order.insertOrder",orderDto); //글쓰기
		return "redirect:/order/list.do";
	}
	
	//주문 추가
	@RequestMapping(value="deletePro.do",method=RequestMethod.GET)
	public String deletePro(Model model, HttpServletRequest request, String ord_num) {
		//1. 파라미터 받기
		int num = Integer.parseInt(ord_num);
				
		//2. 삭제 하기
		sqlSession.selectOne("order.deleteOrder", num);
		return "redirect:/order/list.do";
	}
}
